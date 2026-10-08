import 'package:flutter/material.dart';

import 'easy_01_names_list.dart';
import 'easy_02_icon_list_tile.dart';
import 'easy_03_color_grid.dart';
import 'easy_04_simple_navigation.dart';
import 'easy_05_named_routes.dart';
import 'easy_06_simple_form_validation.dart';
import 'easy_07_counter_set_state.dart';
import 'easy_08_checkbox_toggle.dart';
import 'easy_09_counter_change_notifier.dart';
import 'easy_10_read_vs_watch_provider.dart';

import 'moderate_01_product_catalog.dart';
import 'moderate_02_search_filter_list.dart';
import 'moderate_03_pass_student_data.dart';
import 'moderate_04_pop_data_snackbar.dart';
import 'moderate_05_registration_form.dart';
import 'moderate_06_login_validation.dart';
import 'moderate_07_todo_set_state.dart';
import 'moderate_08_shopping_cart_provider.dart';
import 'moderate_09_star_rating_widget.dart';
import 'moderate_10_star_pattern.dart';

import 'hard_01_multistep_form_wizard.dart';
import 'hard_02_ecommerce_provider.dart';
import 'hard_03_todo_riverpod.dart';
import 'hard_04_counter_bloc.dart';
import 'hard_05_list_grid_toggle.dart';
import 'hard_06_complex_form_save_navigation.dart';
import 'hard_07_theme_switcher_provider.dart';
import 'hard_08_number_pyramid_pattern.dart';
import 'hard_09_nested_bottom_navigation.dart';
import 'hard_10_multi_user_login_provider.dart';

void main() {
  runApp(const PracticalHubApp());
}

class PracticalHubApp extends StatelessWidget {
  const PracticalHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practicals Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Practicals Collection'),
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Easy (1-10)'),
              Tab(text: 'Moderate (1-10)'),
              Tab(text: 'Hard (1-10)'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EasyPracticalsList(),
            ModeratePracticalsList(),
            HardPracticalsList(),
          ],
        ),
      ),
    );
  }
}

class PracticalItem {
  final int no;
  final String title;
  final String description;
  final Widget targetScreen;

  PracticalItem({
    required this.no,
    required this.title,
    required this.description,
    required this.targetScreen,
  });
}

class EasyPracticalsList extends StatelessWidget {
  const EasyPracticalsList({super.key});

  List<PracticalItem> _getItems() => [
        PracticalItem(
          no: 1,
          title: 'Fixed Names List',
          description: 'Display 10 fixed names using ListView.builder',
          targetScreen: const Easy01NamesListScreen(),
        ),
        PracticalItem(
          no: 2,
          title: 'ListTile with Icon',
          description: 'ListView.builder with ListTile icons and text',
          targetScreen: const Easy02IconListTileScreen(),
        ),
        PracticalItem(
          no: 3,
          title: '2-Column Color Grid',
          description: 'List of 6 colors in 2 columns using GridView.builder',
          targetScreen: const Easy03ColorGridScreen(),
        ),
        PracticalItem(
          no: 4,
          title: 'Simple Navigation (push/pop)',
          description: 'Navigate between HomeScreen and SecondScreen',
          targetScreen: const Easy04SimpleNavigationScreen(),
        ),
        PracticalItem(
          no: 5,
          title: 'Named Routes Navigation',
          description: 'Navigate between 3 screens (Home, About, Contact)',
          targetScreen: const Easy05NamedRoutesApp(),
        ),
        PracticalItem(
          no: 6,
          title: 'Simple Form Validation',
          description: 'TextFormField showing Field required error',
          targetScreen: const Easy06SimpleFormValidationScreen(),
        ),
        PracticalItem(
          no: 7,
          title: 'setState() Counter App',
          description: 'Simple counter app with + and - buttons',
          targetScreen: const Easy07CounterSetStateScreen(),
        ),
        PracticalItem(
          no: 8,
          title: 'Checkbox Toggle',
          description: 'Toggle checkbox using setState() showing Checked/Unchecked',
          targetScreen: const Easy08CheckboxToggleScreen(),
        ),
        PracticalItem(
          no: 9,
          title: 'ChangeNotifier & Consumer',
          description: 'CounterModel using ChangeNotifier & Consumer widget',
          targetScreen: const Easy09CounterChangeNotifierScreen(),
        ),
        PracticalItem(
          no: 10,
          title: 'context.read vs context.watch',
          description: 'Provider example showing read vs watch difference',
          targetScreen: const Easy10ReadVsWatchProviderScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return _buildPracticalListView(context, _getItems(), Colors.green);
  }
}

class ModeratePracticalsList extends StatelessWidget {
  const ModeratePracticalsList({super.key});

  List<PracticalItem> _getItems() => [
        PracticalItem(
          no: 1,
          title: 'Product Catalog (3 Columns)',
          description: 'GridView.builder with image, name, price',
          targetScreen: const Moderate01ProductCatalogScreen(),
        ),
        PracticalItem(
          no: 2,
          title: 'Search Filter ListView',
          description: 'Filter ListView items dynamically using TextField',
          targetScreen: const Moderate02SearchFilterListScreen(),
        ),
        PracticalItem(
          no: 3,
          title: 'Pass Student Object Data',
          description: 'Pass Student object from HomeScreen to DetailScreen',
          targetScreen: const Moderate03HomeScreen(),
        ),
        PracticalItem(
          no: 4,
          title: 'Pop Data & Display SnackBar',
          description: 'Return data via Navigator.pop() and show SnackBar',
          targetScreen: const Moderate04HomeScreen(),
        ),
        PracticalItem(
          no: 5,
          title: 'Registration Form',
          description: 'Name, Email, and Password validation form',
          targetScreen: const Moderate05RegistrationFormScreen(),
        ),
        PracticalItem(
          no: 6,
          title: 'Login Form Validation',
          description: 'Login validation with error messages & home redirect',
          targetScreen: const Moderate06LoginValidationScreen(),
        ),
        PracticalItem(
          no: 7,
          title: 'To-Do List (setState)',
          description: 'Add and delete items from a list using setState()',
          targetScreen: const Moderate07TodoSetStateScreen(),
        ),
        PracticalItem(
          no: 8,
          title: 'Shopping Cart Provider',
          description: 'Cart total price auto-updates with Provider',
          targetScreen: const Moderate08ShoppingCartScreen(),
        ),
        PracticalItem(
          no: 9,
          title: 'Star Rating Widget',
          description: '1 to 5 star rating widget using setState()',
          targetScreen: const Moderate09StarRatingWidgetScreen(),
        ),
        PracticalItem(
          no: 10,
          title: 'Star Pattern Printer (*)',
          description: 'Enter number N to print N rows of star pattern',
          targetScreen: const Moderate10StarPatternScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return _buildPracticalListView(context, _getItems(), Colors.orange);
  }
}

class HardPracticalsList extends StatelessWidget {
  const HardPracticalsList({super.key});

  List<PracticalItem> _getItems() => [
        PracticalItem(
          no: 1,
          title: 'Multi-Step Form Wizard',
          description: 'Stepper wizard validating personal info, address, review',
          targetScreen: const Hard01MultiStepFormWizardScreen(),
        ),
        PracticalItem(
          no: 2,
          title: 'Mini E-Commerce App (Provider)',
          description: 'Product list -> Cart (Provider) -> Checkout Summary',
          targetScreen: const Hard02EcommerceApp(),
        ),
        PracticalItem(
          no: 3,
          title: 'Todo App with Riverpod',
          description: 'StateNotifierProvider for add/remove/toggle tasks',
          targetScreen: const Hard03TodoRiverpodApp(),
        ),
        PracticalItem(
          no: 4,
          title: 'Counter App with BLoC',
          description: 'flutter_bloc handling Increment and Decrement events',
          targetScreen: const Hard04CounterBlocApp(),
        ),
        PracticalItem(
          no: 5,
          title: 'List & Grid View Toggle',
          description: 'Toggle ListView and GridView on same screen',
          targetScreen: const Hard05ListGridToggleScreen(),
        ),
        PracticalItem(
          no: 6,
          title: 'Complex Form Save & Navigation',
          description: 'Form.save() passing Dropdown, Checkbox, Text to Summary',
          targetScreen: const Hard06ComplexFormSaveNavigationScreen(),
        ),
        PracticalItem(
          no: 7,
          title: 'Theme Switcher (Provider)',
          description: 'Dark / Light mode theme switcher across full app',
          targetScreen: const Hard07ThemeSwitcherApp(),
        ),
        PracticalItem(
          no: 8,
          title: 'Number Pyramid Pattern',
          description: 'Enter N to generate pyramid number pattern',
          targetScreen: const Hard08NumberPyramidPatternScreen(),
        ),
        PracticalItem(
          no: 9,
          title: 'Nested Navigation (BottomNav)',
          description: 'Separate Navigator stack per Bottom Navigation tab',
          targetScreen: const Hard09NestedBottomNavScreen(),
        ),
        PracticalItem(
          no: 10,
          title: 'Multi-User Login (Provider)',
          description: 'Validate login against List<User> stored in Provider',
          targetScreen: const Hard10MultiUserLoginApp(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return _buildPracticalListView(context, _getItems(), Colors.redAccent);
  }
}

Widget _buildPracticalListView(
  BuildContext context,
  List<PracticalItem> items,
  Color accentColor,
) {
  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: accentColor,
            child: Text(
              '${item.no}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            item.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(item.description),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.targetScreen),
            );
          },
        ),
      );
    },
  );
}
