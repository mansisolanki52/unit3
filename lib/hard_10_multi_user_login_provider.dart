import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User {
  final String username;
  final String email;
  final String password;
  final String role;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });
}

class UserListProvider extends ChangeNotifier {
  final List<User> _users = [
    User(
      username: 'Alice',
      email: 'alice@example.com',
      password: 'password123',
      role: 'Admin',
    ),
    User(
      username: 'Bob',
      email: 'bob@example.com',
      password: 'bobpassword',
      role: 'User',
    ),
    User(
      username: 'Charlie',
      email: 'charlie@example.com',
      password: 'charliepass',
      role: 'Manager',
    ),
  ];

  User? _currentUser;

  List<User> get users => List.unmodifiable(_users);
  User? get currentUser => _currentUser;

  bool login(String emailOrUsername, String password) {
    for (final u in _users) {
      if ((u.email.toLowerCase() == emailOrUsername.toLowerCase() ||
              u.username.toLowerCase() == emailOrUsername.toLowerCase()) &&
          u.password == password) {
        _currentUser = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

class Hard10MultiUserLoginApp extends StatelessWidget {
  const Hard10MultiUserLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserListProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiUserLoginScreen(),
      ),
    );
  }
}

class MultiUserLoginScreen extends StatefulWidget {
  const MultiUserLoginScreen({super.key});

  @override
  State<MultiUserLoginScreen> createState() => _MultiUserLoginScreenState();
}

class _MultiUserLoginScreenState extends State<MultiUserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController(text: 'alice@example.com');
  final _passwordController = TextEditingController(text: 'password123');
  String? _errorMessage;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() {
    if (_formKey.currentState!.validate()) {
      final userProvider = context.read<UserListProvider>();
      final success = userProvider.login(
        _loginController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserDashboardScreen(),
          ),
        );
      } else {
        setState(() {
          _errorMessage =
              'Invalid credentials! Check available registered users below.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserListProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 10: Multi-User Login Provider'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.supervised_user_circle,
                      size: 80, color: Colors.indigo),
                  const SizedBox(height: 16),
                  if (_errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.red.shade100,
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: _loginController,
                    decoration: const InputDecoration(
                      labelText: 'Username or Email',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Field required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Field required' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _performLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
            const Divider(height: 40, thickness: 2),
            const Text(
              'Registered Users in Provider List:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final u = userProvider.users[index];
                return Card(
                  color: Colors.indigo.shade50,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    dense: true,
                    title: Text('${u.username} (${u.role})'),
                    subtitle: Text('Email: ${u.email} | Pass: ${u.password}'),
                    trailing: TextButton(
                      child: const Text('Use Credentials'),
                      onPressed: () {
                        setState(() {
                          _loginController.text = u.email;
                          _passwordController.text = u.password;
                          _errorMessage = null;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserListProvider>();
    final currentUser = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
      ),
      body: Center(
        child: currentUser == null
            ? const Text('No user logged in')
            : Card(
                margin: const EdgeInsets.all(20),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 50),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome, ${currentUser.username}!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Email: ${currentUser.email}'),
                      Text(
                        'Role: ${currentUser.role}',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<UserListProvider>().logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MultiUserLoginScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
