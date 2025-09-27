# Application Prototype - Flutter Mobile App

This is a Flutter mobile application converted from a React/Vite web prototype. The app provides a health companion experience with user authentication, news feed, and forums functionality.

## Features

- **Splash Screen**: Welcome screen with login/register options
- **User Authentication**: Registration and login with form validation
- **Home Feed**: Article feed with health-related content
- **Forums**: Community discussion posts with interaction features
- **Navigation**: Bottom navigation bar for easy screen switching
- **Theming**: Light/dark theme support with system preference detection
- **Responsive Design**: Optimized for mobile devices

## Screens

1. **SplashScreen**: Initial welcome screen with navigation buttons
2. **RegisterScreen**: User registration with form validation
3. **LoginScreen**: User authentication
4. **HomeFeedScreen**: Main feed with articles and content
5. **ForumsScreen**: Community forum with posts and interactions

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device for testing

### Installation

1. **Clone or download the project files**

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

### Building for Production

**Android APK**:
```bash
flutter build apk --release
```

**iOS** (requires macOS and Xcode):
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/
│   ├── app_state_provider.dart    # Screen navigation state
│   └── theme_provider.dart        # Theme management
├── screens/
│   ├── app_screen.dart           # Main app router
│   ├── splash_screen.dart        # Welcome screen
│   ├── register_screen.dart      # User registration
│   ├── login_screen.dart         # User login
│   ├── home_feed_screen.dart     # Main feed
│   └── forums_screen.dart        # Community forums
└── widgets/
    └── bottom_navigation_bar.dart # Custom navigation bar
```

## Dependencies

- **provider**: State management
- **shared_preferences**: Theme persistence
- **fluttertoast**: Toast notifications
- **form_field_validator**: Form validation
- **google_fonts**: Custom typography (optional)

## Key Features Implemented

### State Management
- Provider pattern for state management
- Screen navigation with AppStateProvider
- Theme persistence with ThemeProvider

### UI Components
- Custom splash screen with navigation buttons
- Form validation for registration and login
- Article cards with placeholder content
- Forum posts with user interactions
- Bottom navigation bar with active states

### Theming
- Light and dark theme support
- Custom color schemes matching original design
- Typography using Roboto font family
- Material Design 3 components

### Navigation
- Screen-based navigation (similar to React state switching)
- Bottom navigation bar for main sections
- Back button functionality

## Customization

### Adding New Screens
1. Create a new screen widget in `lib/screens/`
2. Add navigation case in `lib/screens/app_screen.dart`
3. Update `AppStateProvider` if needed

### Modifying Themes
- Edit `lib/providers/theme_provider.dart`
- Customize colors, typography, and component styles
- Add new theme modes as needed

### Adding Features
- Form validation: Use `form_field_validator` package
- Charts: Use `fl_chart` package (already included)
- Notifications: Use `fluttertoast` package (already included)

## Deployment

### Android
1. Generate signed APK: `flutter build apk --release`
2. Install on device or distribute via Google Play Store

### iOS
1. Open `ios/Runner.xcworkspace` in Xcode
2. Configure signing and provisioning profiles
3. Build and archive for App Store distribution

## Notes

- The app uses mock data and placeholder content
- Form validation is implemented but backend integration is not included
- Images are placeholder - replace with actual assets as needed
- The design closely matches the original React prototype
- All navigation and state management is handled client-side

## Troubleshooting

**Common Issues**:
1. **Dependencies**: Run `flutter pub get` to install packages
2. **Build errors**: Check Flutter and Dart SDK versions
3. **Emulator**: Ensure Android emulator is running for testing
4. **Permissions**: Add necessary permissions in `android/app/src/main/AndroidManifest.xml`

**Debug Mode**:
```bash
flutter run --debug
```

**Release Mode**:
```bash
flutter run --release
```

## License

This project is for demonstration purposes. Please ensure you have proper licensing for any assets or dependencies used in production.