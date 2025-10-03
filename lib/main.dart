import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'util.dart';
import 'theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Added import for Supabase Flutter package
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/app_screen.dart';
import 'providers/app_state_provider.dart';

// This function initializes the Supabase client with your project credentials.
// It should be called before runApp to ensure Supabase is ready for use.
// Placeholders: Replace 'YOUR_SUPABASE_URL' and 'YOUR_ANON_KEY' with your actual Supabase project details.
Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url:
        'https://supmtzoiitgvxaakauns.supabase.co', // Placeholder: Replace with your Supabase project URL (e.g., https://yourproject.supabase.co)
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN1cG10em9paXRndnhhYWthdW5zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU0ODM1MzUsImV4cCI6MjA3MTA1OTUzNX0.O7709dB_c8kRSbs99g5gZPaDyu_GkeFWvIkbHFb_3Xk', // Placeholder: Replace with your Supabase anon key
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();

  // Initialize Supabase
  await initializeSupabase();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppStateProvider())],
      child: MaterialApp(
        title: 'A4A',
        debugShowCheckedModeBanner: false,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const AppScreen(),
      ),
    );
  }
}
