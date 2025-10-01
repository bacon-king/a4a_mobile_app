import 'package:flutter/material.dart';

class AppStateProvider with ChangeNotifier {
  String _currentScreen = 'splash'; // Default screen
  final List<String> _screenHistory = []; // Track navigation history
  
  String? _loggedInEmail;
  String? get loggedInEmail => _loggedInEmail;
  String get currentScreen => _currentScreen;

  void setLoggedInEmail(String email) {
    _loggedInEmail = email;
    notifyListeners();
  }
  
  // Navigate to a new screen and update history
  void navigateToScreen(String screen) {
    if (_currentScreen != screen) {
      _screenHistory.add(_currentScreen);
      _currentScreen = screen;
      notifyListeners();
    }
  }

  // Go back to the previous screen
  void goBack() {
    if (_screenHistory.isNotEmpty) {
      _currentScreen = _screenHistory.removeLast();
      notifyListeners();
    } else {
      // Fallback to splash if no history
      _currentScreen = 'splash';
      notifyListeners();
    }
  }

  // Clear history and reset to a specific screen (e.g., logout)
  void resetToScreen(String screen) {
    _screenHistory.clear();
    _currentScreen = screen;
    notifyListeners();
  }
}