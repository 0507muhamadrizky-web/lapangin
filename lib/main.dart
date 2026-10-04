import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config/app_theme.dart';
import 'config/app_router.dart';
import 'data/providers/auth_provider.dart';
import 'data/providers/venue_provider.dart';
import 'data/providers/booking_provider.dart';
import 'data/providers/notification_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const LapanginApp());
}

class LapanginApp extends StatelessWidget {
  const LapanginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VenueProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp.router(
        title: 'Lapangin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
