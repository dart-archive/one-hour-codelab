// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:angular/angular.dart';

enum Color { gray, green, gold }

@Component(
  selector: 'visualize-winnings',
  styleUrls: const ['visualize_winnings.css'],
  templateUrl: 'visualize_winnings.html',
  directives: const [NgStyle],
)
class VisualizeWinningsComponent implements OnInit {
  static const int _pointSize = 5;

  static const int _pointMargin = 1;

  @ViewChild('canvas')
  ElementRef canvas;

  CanvasRenderingContext2D _ctx;

  int _width;

  int _height;

  int _x = 0;

  int _y = 0;

  bool _hasData = false;

  bool get hasData => _hasData;

  void increaseCoordinates() {
    final pointSpace = _pointSize + _pointMargin;

    _x += pointSpace;
    if (_x + pointSpace > _width) {
      _x = 0;
      _y += pointSpace;
      _ctx.clearRect(0, _y, _width, pointSpace * 2);
    }
    if (_y + pointSpace > _height) {
      _y = 0;
      _ctx.clearRect(0, _y, _width, pointSpace * 2);
    }
  }

  @override
  ngOnInit() {
    _ctx = canvas.nativeElement.context2D;
    _width = canvas.nativeElement.width;
    _height = canvas.nativeElement.height;
  }

  void renderPoint(Color color) {
    switch (color) {
      case Color.gray:
        _ctx.setFillColorHsl(0, 0, 74);
        break;
      case Color.green:
        _ctx.setFillColorHsl(66, 70, 54);
        break;
      case Color.gold:
        _ctx.setFillColorHsl(36, 100, 50);
        break;
    }
    _ctx.fillRect(_x, _y, _pointSize, _pointSize);
    _ctx.closePath();
    increaseCoordinates();
    _hasData = true;
  }

  void reset() {
    _x = 0;
    _y = 0;
    _hasData = false;
    _ctx?.clearRect(0, 0, _width, _height);
  }

  void visualizeBigWin() {
    renderPoint(Color.gold);
  }

  void visualizeLoss() {
    renderPoint(Color.gray);
  }

  void visualizeWin() {
    renderPoint(Color.green);
  }
}
