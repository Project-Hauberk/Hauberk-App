part of 'package:hauberk/main.dart';

class AssistantView extends StatelessWidget {
  const AssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      activeTabNum: 3,
      viewLabel: 'Assistant',
      children: [
        Text(
          'Coming soon!',
          style: body1.apply(),
        )
      ],
    );
  }
}
