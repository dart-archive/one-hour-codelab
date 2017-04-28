// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:components_codelab/help/help.dart';
import 'package:components_codelab/scores/scores.dart';
import 'package:components_codelab/settings/settings.dart';
import 'package:components_codelab/settings/settings_component.dart';
import 'package:components_codelab/stats/stats.dart';
import 'package:components_codelab/visualize_winnings/visualize_winnings.dart';
import 'package:intl/intl.dart';

const _fastPulse = const Duration(milliseconds: 5);

const _normalPulse = const Duration(milliseconds: 200);

@Component(
  selector: 'lottery-simulator',
  styleUrls: const ['lottery_simulator.css'],
  templateUrl: 'lottery_simulator.html',
  directives: const [
    HelpComponent,
    ScoresComponent,
    StatsComponent,
    VisualizeWinningsComponent,
    SettingsComponent,
  ],
  providers: const [Settings],
)
class AppComponent implements OnInit {
  final Settings _settings;

  Timer _pulse;

  /// The amount of cash the person would have if they saved instead of betting.
  int altCash;

  /// The amount of cash the bettor has.
  int cash;

  /// The day of the simulation, starting at 0.
  int day;

  @ViewChild('vis')
  VisualizeWinningsComponent vis;

  /// The phase of the day.
  ///
  /// If `0`, it's when the user gets their income. If `1`, it's when they
  /// bet and invest.
  int phase;

  bool inProgress = false;

  /// A map that keeps track of how many occurrences of winning of a given
  /// value there were.
  ///
  /// In other words, `winningsMap[value] = occurrencesCount`.
  final Map<int, int> winningsMap = new Map<int, int>();

  bool _fastEnabled = false;

  final _dateFormat = new DateFormat.yMMMMd();

  AppComponent(this._settings);

  String get currentDay {
    var date = settings.now.add(new Duration(days: day));
    return _dateFormat.format(date);
  }

  bool get endOfDays => day >= _settings.maxDays;

  bool get fastEnabled => _fastEnabled;

  set fastEnabled(bool value) {
    _fastEnabled = value;
    if (inProgress) _reconfigurePulse();
  }

  bool get notEnoughMoney => cash < _settings.lottery.ticketPrice;

  int get progress => (day / _settings.maxDays * 100).round();

  Settings get settings => _settings;

  void bet() {
    int bettedToday = 0;
    int wonToday = 0;

    while (!notEnoughMoney &&
        settings.strategy
            .canContinue(bettedToday, wonToday, settings.dailyDisposable)) {
      cash -= _settings.lottery.ticketPrice;
      bettedToday += _settings.lottery.ticketPrice;
      var ticket = _settings.lottery.bet();
      cash += ticket.value;
      wonToday += ticket.value;

      // Visualize the result.
      if (ticket.value == 0) {
        vis.visualizeLoss();
      } else if (ticket.value < settings.dailyDisposable * 50) {
        vis.visualizeWin();
      } else {
        vis.visualizeBigWin();
      }
      winningsMap.putIfAbsent(ticket.value, () => 0);
      winningsMap[ticket.value] += 1;
    }
  }

  @override
  ngOnInit() {
    reset();
  }

  void pause() {
    _pulse?.cancel();
    inProgress = false;
  }

  void play() {
    inProgress = true;
    _reconfigurePulse();
  }

  void reset() {
    cash = _settings.initialCash;
    altCash = cash;
    day = 0;
    phase = 0;
    winningsMap.clear();
    vis.reset();
    pause();
  }

  /// Elapse one day.
  void step() {
    if (endOfDays) {
      pause();
      return;
    }

    // Add disposable money (phase 0).
    if (phase == 0) {
      day += 1;
      cash += _settings.dailyDisposable;
      altCash += _settings.dailyDisposable;
      phase = 1;
      return;
    }

    // Bet (phase 1)
    bet();

    // Add annual interest.
    if (day % 365 == 0) {
      double interest = altCash * (_settings.interestRate / 100);
      altCash += interest.floor();
    }
    phase = 0;
  }

  void updateFromSettings() {
    if (day == 0 && phase == 0) {
      cash = _settings.initialCash;
      altCash = cash;
    }
  }

  void _reconfigurePulse() {
    _pulse?.cancel();
    _pulse = new Timer.periodic(
        _fastEnabled ? _fastPulse : _normalPulse, (_) => step());
  }
}
