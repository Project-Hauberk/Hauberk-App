part of 'package:hauberk/main.dart';

class AddBudgetedEventForm extends StatefulWidget {
  const AddBudgetedEventForm({super.key});

  @override
  State<StatefulWidget> createState() => AddBudgetedEventFormState();
}

class AddBudgetedEventFormState extends State<AddBudgetedEventForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (ctx) => Container(
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
          child: Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: const SliderThemeData(
                activeTrackColor: HauberkColors.brightGreen2,
                inactiveTrackColor: HauberkColors.brightGreen1,
                thumbColor: HauberkColors.brightGreen2,
              ),
            ),
            child: SizedBox(
              width: Dimensions.width(),
              height: Dimensions.height() * 0.7,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: Dimensions.width() * 0.7,
                  child: Column(
                    children: [
                      // Name
                      TextField(
                        style: body1.apply(),
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Give the event a name',
                          hintStyle: body1.apply(
                            TextStyle(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Amount
                      TextField(
                        controller: amountController,
                        style: body1.apply(const TextStyle(fontSize: 14)),
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            size: 24,
                            color: HauberkColors.brightGreen5.withOpacity(0.5),
                          ),
                          hintText: 'Budgeted Amount',
                          hintStyle: body1.apply(
                            TextStyle(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Event Date
                      TextField(
                        controller: eventDateController,
                        style: body1.apply(),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Event Date',
                          hintStyle: body1.apply(
                            TextStyle(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.5),
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
                            final BudgetedEvent event = BudgetedEvent(
                              name: nameController.text,
                              amount: double.parse(amountController.text),
                              date: DateUtils.fromDDMMYYYY(
                                      eventDateController.text)
                                  .millisecondsSinceEpoch,
                              tags: [],
                            );

                            if (context.mounted) {
                              Navigator.of(context).pop(event);
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.2),
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
      ),
    );
  }
}
