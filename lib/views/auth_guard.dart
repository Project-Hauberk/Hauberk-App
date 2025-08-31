part of 'package:hauberk/main.dart';

mixin AuthGuard<T extends StatefulWidget> on State<T> {
  WidgetBuilder authGuarded({required WidgetBuilder builder}) {
    return FirebaseAuth.instance.currentUser == null
        ? (BuildContext _) => Scaffold(
              backgroundColor: HauberkColors.darkGreen5,
              body: Center(
                child: Container(
                  width: Dimensions.width() * 0.8,
                  height: Dimensions.height() * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: SignInScreen(
                    providers: [EmailAuthProvider()],
                    actions: [
                      AuthStateChangeAction<SignedIn>((_, __) {
                        setState(() {});
                      }),
                    ],
                  ),
                ),
              ),
            )
        : builder;
  }
}
