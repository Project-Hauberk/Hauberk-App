part of 'package:hauberk/main.dart';

class HauberkNavbar extends StatelessWidget {
  final List<IconData> icons;
  final List<VoidCallback> actions;
  final int activeTab;
  final double height;

  const HauberkNavbar({
    required this.height,
    required this.activeTab,
    required this.icons,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / icons.length;
    final List<Widget> buttons = [];
    for (int i = 0; i < icons.length; i++) {
      buttons.add(
        NavbarButton(
          action: actions[i],
          icon: icons[i],
          active: i == activeTab,
          height: height,
          width: width,
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        color: HauberkColors.darkGreen5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border.all(
          color: HauberkColors.brightGreen5,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: HauberkColors.brightGreen5.withOpacity(0.45),
            offset: const Offset(0, -4),
            blurRadius: 50,
          ),
        ],
      ),
      child: Row(
        children: buttons,
      ),
    );
  }
}

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
