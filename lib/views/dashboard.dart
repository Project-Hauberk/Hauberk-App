part of 'package:hauberk/main.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        bottomNavigationBar: mobileNavBar(context),
        body: const SizedBox(),
      ),
    );
  }
}
