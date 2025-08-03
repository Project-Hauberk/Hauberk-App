part of 'package:hauberk/main.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HauberkColors.darkGreen5,
      bottomNavigationBar: mobileNavBar(context, 3),
      body: const Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(
            color: HauberkColors.brightGreen5,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
