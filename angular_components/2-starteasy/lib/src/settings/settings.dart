// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:components_codelab/src/lottery/lottery.dart';

final DateTime _now = new DateTime.now();

typedef bool Inhibitor(int bettedToday, int wonToday, int dailyDisposable);

@Injectable()
class Settings {
  int initialCash = 10;

  /// The amount of cash that the player has on them each new day.
  int dailyDisposable = 2;

  Strategy strategy = Strategy._strategies.first;

  int interestRate = 1;

  int years = 3;

  Lottery lottery = Lottery.lotteries.first;

  DateTime get now => _now;

  Settings();

  List<Lottery> get lotteries => Lottery.lotteries;

  int get maxDays => new DateTime(
          _now.year + years, _now.month, _now.day, _now.hour, _now.minute)
      .difference(_now)
      .inDays;

  List<Strategy> get strategies => Strategy._strategies;
}

class Strategy {
  static final conservative = new Strategy(
      "Conservative",
      "only disposable income",
      "Buy one ticket per day. Buy more only if daily disposable income "
      "allows (in other words, do not use winnings to buy more tickets on "
      "the same day).",
      (bettedToday, wonToday, dailyDisposable) =>
          bettedToday < dailyDisposable);

  static final reinvest = new Strategy(
      "Reinvest",
      "disposable income and winnings",
      "Re-invest the day's winning tickets to buy new ones (unless the "
      "winnings are 10x more than the daily disposable income, in which case "
      "keep the cash).",
      (bettedToday, wonToday, dailyDisposable) =>
          bettedToday < dailyDisposable + wonToday &&
          wonToday < dailyDisposable * 10);

  static final allIn = new Strategy(
      "All in",
      "everything",
      "Use all available cash to buy tickets every day (even if we just won "
      "the jackpot — bet it all back).",
      (bettedToday, wonToday, dailyDisposable) => true);

  static final List<Strategy> _strategies = [conservative, reinvest, allIn];

  final String shortName;

  final String name;

  final String description;

  final Inhibitor canContinue;

  Strategy(this.shortName, this.name, this.description, this.canContinue);
}
