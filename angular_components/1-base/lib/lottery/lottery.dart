// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

enum Category { jackpot, win, lose }

abstract class Lottery {
  static final List<Lottery> lotteries = [
    new Powerball(new Random()),
    new SimpleLottery(new Random())
  ];

  String get description;
  String get name;
  String get shortName;
  int get ticketPrice;

  Ticket bet();
}

class Powerball implements Lottery {
  final String shortName = "Powerball";
  final String name = "US Powerball";
  final String description = "Powerball is one of the most popular American "
      "lottery games. Its chances of winning are well known and even published "
      "on powerball.com.";

  final Random _random;
  final ticketPrice = 2;
  final jackpot = 40000000;

  Powerball(this._random);

  /// Chances according to http://www.powerball.com/powerball/pb_prizes.asp.
  Ticket bet() {
    double draw = _random.nextDouble();

    if (draw < 1 / 292201338.0) {
      return new Ticket(jackpot, Category.jackpot);
    }
    if (draw < 1 / 11688053.52) {
      return new Ticket(1000000, Category.win);
    }
    if (draw < 1 / 913129.18) {
      return new Ticket(50000, Category.win);
    }
    if (draw < 1 / 36525.17) {
      return new Ticket(100, Category.win);
    }
    if (draw < 1 / 14494.11) {
      return new Ticket(100, Category.win);
    }
    if (draw < 1 / 579.76) {
      return new Ticket(7, Category.win);
    }
    if (draw < 1 / 701.33) {
      return new Ticket(7, Category.win);
    }
    if (draw < 1 / 91.98) {
      return new Ticket(4, Category.win);
    }
    if (draw < 1 / 38.32) {
      return new Ticket(4, Category.win);
    }
    return new Ticket(0, Category.lose);
  }
}

class SimpleLottery implements Lottery {
  final String shortName = "Good Guy Lottery";
  final String name = "Mythical Good Guy Lottery";
  final String description = "This made-up lottery is literally ‘too good to "
      "be true.’ It wouldn't be financially viable, as it pays out, "
      "on average, almost all of its revenue in winnings.";

  final Random _random;
  final ticketPrice = 2;

  SimpleLottery(this._random);

  Ticket bet() {
    double draw = _random.nextDouble();
    if (draw < 0.01) {
      return new Ticket(100, Category.jackpot);
    }
    if (draw < 0.1) {
      return new Ticket(10, Category.win);
    }
    return new Ticket(0, Category.lose);
  }
}

class Ticket {
  final int value;
  final Category category;

  Ticket(this.value, this.category);
}
