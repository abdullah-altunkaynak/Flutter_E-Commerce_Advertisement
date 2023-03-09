import 'package:flutter/material.dart';

class KumlukSizes {
  static double _width = 1080;
  static double _height = 1920;
  static double _aspectRatio = _height / _width;
  static double _topPadding = 60;
  static double _bottomPadding = 100;
  static double _appBarHeight = 150;

  static void setSizes(BuildContext context) {
    _topPadding = MediaQuery.of(context).padding.top;
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _aspectRatio = _height / _width;
    _topPadding = MediaQuery.of(context).padding.top;
    _bottomPadding = (_height / 14) + (_height / 36);
    _appBarHeight = _height / 16;
  }

  static double getWidth() {
    return _width;
  }

  static double getHeight() {
    return _height;
  }

  static double getAspectRatio() {
    return _aspectRatio;
  }

  static double getTopPadding() {
    return _topPadding;
  }

  static double getBottomPadding() {
    return _bottomPadding;
  }

  static double getAppBarHeight({bool tabBar = false}) {
    if (tabBar) {
      return _height / 20;
    } else {
      return _appBarHeight;
    }
  }

  //VARIABLES
  static double _buttonSize = _height / 20;
  static double _buttonText = _height / 46;
  static double _buttonBorder = 1;
  static EdgeInsets _buttonPadding =
      EdgeInsets.symmetric(vertical: _buttonSize / 6, horizontal: _width / 36);

  static double _appBar = _height / 16;
  static double _appBarTitle = _height / 32;
  static double _appBarIcon = _height / 32;

  static double _bottomBarHeight = _height / 14;
  static EdgeInsets _bottomBarItemMargin =
      EdgeInsets.symmetric(horizontal: _width / 72);
  static EdgeInsets _bottomBarPadding =
      EdgeInsets.symmetric(vertical: _height / 128);
  static EdgeInsets _bottomBarMargin = EdgeInsets.only(top: _height / 48);
  static double _bottomBarMessages = _height / 24;

  static double _showPopUpBorder = 4;
  static double _showPopUpTitle = _height / 40;
  static double _showPopUpDesc = _height / 48;
  static EdgeInsets _showPopUpPadding =
      EdgeInsets.symmetric(horizontal: _width / 20, vertical: _width / 36);
  static EdgeInsets _showPopUpMargin =
      EdgeInsets.symmetric(horizontal: _width / 24);
  static double _showPopUpButton = _height / 20;

  static double _snackBarBorder = 2;
  static double _snackBarTitle = _height / 42;
  static double _snackBarDesc = _height / 48;
  static EdgeInsets _snackBarPadding =
      EdgeInsets.symmetric(horizontal: _width / 36, vertical: _height / 48);
  static EdgeInsets _snackBarMargin =
      EdgeInsets.symmetric(horizontal: _width / 20, vertical: _height / 42);

  static double _textFieldTitle = _height / 52;
  static double _textFieldHint = _height / 52;
  static double _textFieldText = _height / 42;
  static double _textFieldBorder = 3;
  static double _textFieldHeight = _height / 20;
  static double _textFieldIcon = _height / 32;

  static double _swipeCardBorder = 1;
  static double _swipeCardRapport = _width / 7;
  static double _swipeCardRapportText = _width / 24;
  static double _swipeCardRapportBorder = 1;
  static double _swipeCardGender = _width / 12;
  static EdgeInsets _swipeCardGenderPadding = EdgeInsets.all(4);
  static double _swipeCardGenderBorder = 1.4;
  static double _swipeCardName = _width / 20;
  static double _swipeCardAge = _width / 24;
  static double _swipeCardDivider = _height / 500;
  static double _swipeCardDesc = _width / 26;
  static double _swipeCardElement = _width / 20;
  static double _swipeCardButton = _width / 16;

  static double _frameBorder = 1;
  static double _frameTitle = _width / 28;

  static double _chatAppBar = _height / 12;
  static double _chatIcon = _width / 24;
  static double _chatClock = _width / 36;
  static double _chatMessageText = _width / 28;
  static double _chatCoinMessage = _width / 28;
  //VARIABLES

  //GET METHODS
  static get buttonSize => _buttonSize;
  static get buttonText => _buttonText;
  static get buttonBorder => _buttonBorder;
  static get buttonPadding => _buttonPadding;

  static get appBar => _appBar;
  static get appBarTitle => _appBarTitle;
  static get appBarIcon => _appBarIcon;

  static get bottomBarHeight => _bottomBarHeight;
  static get bottomBarItemMargin => _bottomBarItemMargin;
  static get bottomBarPadding => _bottomBarPadding;
  static get bottomBarMargin => _bottomBarMargin;
  static get bottomBarMessages => _bottomBarMessages;

  static get showPopUpBorder => _showPopUpBorder;
  static get showPopUpTitle => _showPopUpTitle;
  static get showPopUpDesc => _showPopUpDesc;
  static get showPopUpPadding => _showPopUpPadding;
  static get showPopUpMargin => _showPopUpMargin;
  static get showPopUpButton => _showPopUpButton;

  static get snackBarBorder => _snackBarBorder;
  static get snackBarTitle => _snackBarTitle;
  static get snackBarDesc => _snackBarDesc;
  static get snackBarPadding => _snackBarPadding;
  static get snackBarMargin => _snackBarMargin;

  static get textFieldTitle => _textFieldTitle;
  static get textFieldHint => _textFieldHint;
  static get textFieldText => _textFieldText;
  static get textFieldBorder => _textFieldBorder;
  static get textFieldHeight => _textFieldHeight;
  static get textFieldIcon => _textFieldIcon;

  static get swipeCardBorder => _swipeCardBorder;
  static get swipeCardRapport => _swipeCardRapport;
  static get swipeCardRapportText => _swipeCardRapportText;
  static get swipeCardRapportBorder => _swipeCardRapportBorder;
  static get swipeCardGender => _swipeCardGender;
  static get swipeCardGenderPadding => _swipeCardGenderPadding;
  static get swipeCardGenderBorder => _swipeCardGenderBorder;
  static get swipeCardName => _swipeCardName;
  static get swipeCardAge => _swipeCardAge;
  static get swipeCardDivider => _swipeCardDivider;
  static get swipeCardDesc => _swipeCardDesc;
  static get swipeCardElement => _swipeCardElement;
  static get swipeCardButton => _swipeCardButton;

  static get frameBorder => _frameBorder;
  static get frameTitle => _frameTitle;

  static get chatAppBar => _chatAppBar;
  static get chatIcon => _chatIcon;
  static get chatClock => _chatClock;
  static get chatMessageText => _chatMessageText;
  static get chatCoinMessage => _chatCoinMessage;
  //GET METHODS

}
