import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/router/app_routes.dart';
import 'package:overload_pro_app/core/widgets/custom_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({required this.child, super.key});
  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentIndex = _getInitialIndex();
  }

  int _getInitialIndex() {
    final route = ModalRoute.of(context)?.settings.name;
    switch (route) {
      case AppRoutes.main:
        return 0;
      case AppRoutes.history:
        return 1;
      case AppRoutes.profile:
        return 2;
      default:
        return 0;
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.main);
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.history);
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onPageChanged,
      ),
      floatingActionButton: _currentIndex != 2
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.addWorkout),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
