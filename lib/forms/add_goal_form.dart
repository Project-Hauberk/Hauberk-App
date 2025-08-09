part of 'package:hauberk/main.dart';

class AddGoalForm extends StatefulWidget {
  const AddGoalForm({super.key});

  @override
  State<StatefulWidget> createState() => AddGoalFormState();
}

class AddGoalFormState extends State<AddGoalForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Colors.transparent,
      builder: (ctx) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: Dimensions.width(),
          height: Dimensions.height() * 0.7,
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
                color: HauberkColors.brightGreen5.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: Dimensions.width(),
              height: Dimensions.height() * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Name
                    TextField(
                      style: body1.apply(),
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Describe your goal',
                        hintStyle: body1.apply(
                          TextStyle(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Target
                    TextField(
                      controller: targetController,
                      style: body1.apply(const TextStyle(fontSize: 14)),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.attach_money,
                          size: 24,
                          color: HauberkColors.brightGreen5.withOpacity(0.5),
                        ),
                        hintText: 'Target Amount',
                        hintStyle: body1.apply(
                          TextStyle(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Deadline
                    TextField(
                      controller: deadlineController,
                      style: body1.apply(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Deadline',
                        hintStyle: body1.apply(
                          TextStyle(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          final Goal goal = Goal(
                              name: nameController.text,
                              target: double.parse(targetController.text),
                              deadline: DateUtils.fromDDMMYYYY(
                                      deadlineController.text)
                                  .millisecondsSinceEpoch);

                          await goalsColl.add(goal);

                          if (context.mounted) {
                            Navigator.of(context).pop(goal);
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HauberkColors.brightGreen5.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Text(
                              'Finish',
                              style: body1.apply(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    targetController.dispose();
    deadlineController.dispose();
    super.dispose();
  }
}
