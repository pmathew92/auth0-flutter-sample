import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'auth_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _isLoggedIn = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      await _authService.login();
      if (mounted) setState(() => _isLoggedIn = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);
    try {
      await _authService.logout();
      if (mounted) setState(() => _isLoggedIn = false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleFetchCredentials() async {
    setState(() => _isLoading = true);
    try {
      final credentials = await _authService.fetchCredentials();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Access Token: ${credentials.accessToken.substring(0, 20)}...')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fetch credentials failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleHasValidCredentials() async {
    setState(() => _isLoading = true);
    try {
      final hasValid = await _authService.hasValidCredentials();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Has valid credentials: $hasValid')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Check credentials failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Auth0 Demo'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleLogout,
                    child: const Text('Logout'),
                  ),
                  if (_isLoggedIn) ...[
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _handleFetchCredentials,
                      child: const Text('Fetch Credentials'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _handleHasValidCredentials,
                      child: const Text('Check Has Valid Credentials'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
