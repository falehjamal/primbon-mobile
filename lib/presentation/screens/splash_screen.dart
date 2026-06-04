import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2800), _goHome);
  }

  void _goHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: _goHome,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(height: 28),
                Text(
                  AppStrings.appTitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.appDescription,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
