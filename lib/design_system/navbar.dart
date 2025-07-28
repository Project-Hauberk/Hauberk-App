part of 'package:hauberk/main.dart';

BottomNavigationBar mobileNavBar(BuildContext context) => BottomNavigationBar(
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
