import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JWT Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SplashDecider(),
    );
  }
}

// Перевіряє чи є збережений токен і одразу веде на потрібний екран
class SplashDecider extends StatefulWidget {
  const SplashDecider({super.key});
  @override
  State<SplashDecider> createState() => _SplashDeciderState();
}

class _SplashDeciderState extends State<SplashDecider> {
  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    await context.read<AuthProvider>().checkAuth();
    if (!mounted) return;
    final status = context.read<AuthProvider>().status;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => status == AuthStatus.authenticated
            ? const ProfileScreen()
            : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
