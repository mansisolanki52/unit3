import 'package:flutter/material.dart';

class Hard09NestedBottomNavScreen extends StatefulWidget {
  const Hard09NestedBottomNavScreen({super.key});

  @override
  State<Hard09NestedBottomNavScreen> createState() =>
      _Hard09NestedBottomNavScreenState();
}

class _Hard09NestedBottomNavScreenState
    extends State<Hard09NestedBottomNavScreen> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // Pop to first route if tapping current tab again
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final navigator = _navigatorKeys[_selectedIndex].currentState;
        if (navigator != null && navigator.canPop()) {
          navigator.pop();
        } else {
          // Allow system pop if current tab navigator cannot pop
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildTabNavigator(0, const Tab1HomeScreen()),
            _buildTabNavigator(1, const Tab2SearchScreen()),
            _buildTabNavigator(2, const Tab3ProfileScreen()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home Tab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search Tab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile Tab',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigator(int index, Widget rootScreen) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => rootScreen,
        );
      },
    );
  }
}

// TAB 1
class Tab1HomeScreen extends StatelessWidget {
  const Tab1HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Stack - Level 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Tab1DetailScreen(),
              ),
            );
          },
          child: const Text('Push Deep Home Detail Screen'),
        ),
      ),
    );
  }
}

class Tab1DetailScreen extends StatelessWidget {
  const Tab1DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Stack - Level 2'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Deep Detail in Home Tab!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Switch tabs and return: this stack state is preserved!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// TAB 2
class Tab2SearchScreen extends StatelessWidget {
  const Tab2SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Stack - Level 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Tab2ResultsScreen(),
              ),
            );
          },
          child: const Text('Search Category -> Search Results'),
        ),
      ),
    );
  }
}

class Tab2ResultsScreen extends StatelessWidget {
  const Tab2ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Stack - Level 2'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Search Results Screen'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// TAB 3
class Tab3ProfileScreen extends StatelessWidget {
  const Tab3ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Stack - Level 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Tab3AccountSettingsScreen(),
              ),
            );
          },
          child: const Text('Open Account Settings'),
        ),
      ),
    );
  }
}

class Tab3AccountSettingsScreen extends StatelessWidget {
  const Tab3AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Stack - Level 2'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Account Settings'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop Back'),
            ),
          ],
        ),
      ),
    );
  }
}
