import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  String _currentScreen = 'splash';

  String get currentScreen => _currentScreen;

  void navigateToScreen(String screen) {
    _currentScreen = screen;
    notifyListeners();
  }

  void goBack() {
    switch (_currentScreen) {
      case 'register':
      case 'login':
        _currentScreen = 'splash';
        break;
      case 'home':
      case 'forum':
        _currentScreen = 'splash';
        break;
      case 'faq':
        _currentScreen = 'account';
        break;
      case 'edit_profile':
      case 'change_password':
        _currentScreen = 'account';
        break;
      default:
        _currentScreen = 'splash';
    }
    notifyListeners();
  }
}
