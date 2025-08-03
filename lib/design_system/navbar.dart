part of 'package:hauberk/main.dart';

BottomNavigationBar mobileNavBar(BuildContext context, [int index = 0]) =>
    BottomNavigationBar(
      backgroundColor: HauberkColors.darkGreen5,
      unselectedItemColor: HauberkColors.brightGreen5.withOpacity(0.3),
      selectedItemColor: HauberkColors.brightGreen5.withOpacity(0.7),
      showUnselectedLabels: true,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      items: const [
        BottomNavigationBarItem(
          label: 'Dashboard',
          icon: Icon(
            Icons.dashboard,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Transactions',
          icon: Icon(
            Icons.table_chart,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Budgeting',
          icon: Icon(
            Icons.pie_chart,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.person,
          ),
        ),
      ],
      onTap: (value) => switch (value) {
        0 => Navigator.of(context).pushNamed('/dashboard'),
        1 => Navigator.of(context).pushNamed('/transactions'),
        2 => Navigator.of(context).pushNamed('/budgeting'),
        3 => Navigator.of(context).pushNamed('/profile'),
        int _ => Navigator.of(context).pushNamed('/dashboard'),
      },
    );
