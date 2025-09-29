import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import 'splash_screen.dart';
import 'register_screen.dart';
import 'login_screen.dart';
import 'home_feed_screen.dart';
import 'forums_screen.dart';
import 'profile_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        switch (appState.currentScreen) {
          case 'register':
            return RegisterScreen(
              onBack: () => appState.goBack(),
              onLogin: () => appState.navigateToScreen('login'),
            );
          case 'login':
            return LoginScreen(
              onBack: () => appState.goBack(),
              onRegister: () => appState.navigateToScreen('register'),
              onLoginSuccess: () => appState.navigateToScreen('home'),
            );
          case 'home':
            return HomeFeedScreen(
              onNavigate: (section) => appState.navigateToScreen(section),
            );
          case 'forum':
            return ForumsScreen(
              onNavigate: (section) => appState.navigateToScreen(section),
            );
          case 'account':
            return ProfileScreen(
              onNavigate: (section) => appState.navigateToScreen(section),
            );
          case 'edit_profile':
            return EditProfileScreen(
              onNavigate: (section) => appState.navigateToScreen(section),
            );
          case 'change_password':
            return ChangePasswordScreen(
              onNavigate: (section) => appState.navigateToScreen(section),
            );
          default:
            return SplashScreen(
              onRegister: () => appState.navigateToScreen('register'),
              onLogin: () => appState.navigateToScreen('login'),
            );
        }
      },
    );
  }
}
