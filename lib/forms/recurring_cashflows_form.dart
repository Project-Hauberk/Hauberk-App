part of 'package:hauberk/main.dart';

class RecurringCashflowsForm extends StatefulWidget {
  const RecurringCashflowsForm({super.key});

  @override
  State<StatefulWidget> createState() => RecurringCashflowsFormState();
}

class RecurringCashflowsFormState extends State<RecurringCashflowsForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController colorController =
      TextEditingController(text: generateColorHex());
  final TextEditingController wefDateController = TextEditingController(
    text: DateTime.now().toDDMMYYYY(),
  );

  Set<String> cashflowType = {'inflow'};
  Set<String> recurrenceType = {'daily'};

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
          child: SizedBox(
            width: Dimensions.width(),
            height: Dimensions.height() * 0.7,
            child: SingleChildScrollView(
              child: SizedBox(
                width: Dimensions.width() * 0.7,
                child: Column(
                  children: [
                    // Cashflow Type
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'inflow',
                          label: Text(
                            'Inflow',
                            style: button1.apply(),
                          ),
                        ),
                        ButtonSegment(
                          value: 'outflow',
                          label: Text(
                            'Outflow',
                            style: button1.apply(),
                          ),
                        ),
                      ],
                      selected: cashflowType,
                      onSelectionChanged: (value) => setState(() {
                        cashflowType = value;
                      }),
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.4),
                          ),
                        ),
                        backgroundColor: WidgetStateColor.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return HauberkColors.brightGreen5.withOpacity(0.4);
                          } else if (states.contains(WidgetState.hovered)) {
                            return HauberkColors.brightGreen5.withOpacity(0.1);
                          } else if (states.contains(WidgetState.pressed)) {
                            return HauberkColors.brightGreen5.withOpacity(0.2);
                          } else if (states.contains(WidgetState.focused)) {
                            return HauberkColors.brightGreen5.withOpacity(0.1);
                          } else {
                            return HauberkColors.brightGreen5.withOpacity(0.05);
                          }
                        }),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Name
                    TextField(
                      style: body1.apply(),
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Give this ${cashflowType.first} a name',
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
                    // Recurrence
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'daily',
                          label: Text('Daily', style: button1.apply()),
                        ),
                        ButtonSegment(
                          value: 'weekly',
                          label: Text('Weekly', style: button1.apply()),
                        ),
                        ButtonSegment(
                          value: 'bi-weekly',
                          label: Text('Bi-Weekly', style: button1.apply()),
                        ),
                        ButtonSegment(
                          value: 'monthly',
                          label: Text('Monthly', style: button1.apply()),
                        ),
                        ButtonSegment(
                          value: 'quarterly',
                          label: Text('Quarterly', style: button1.apply()),
                        ),
                        ButtonSegment(
                          value: 'yarly',
                          label: Text('Yearly', style: button1.apply()),
                        ),
                      ],
                      selected: recurrenceType,
                      onSelectionChanged: (value) => setState(() {
                        recurrenceType = value;
                      }),
                      showSelectedIcon: false,
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(
                            color: HauberkColors.brightGreen5.withOpacity(0.4),
                          ),
                        ),
                        backgroundColor: WidgetStateColor.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return HauberkColors.brightGreen5.withOpacity(0.4);
                          } else if (states.contains(WidgetState.hovered)) {
                            return HauberkColors.brightGreen5.withOpacity(0.1);
                          } else if (states.contains(WidgetState.pressed)) {
                            return HauberkColors.brightGreen5.withOpacity(0.2);
                          } else if (states.contains(WidgetState.focused)) {
                            return HauberkColors.brightGreen5.withOpacity(0.1);
                          } else {
                            return HauberkColors.brightGreen5.withOpacity(0.05);
                          }
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // WEF Date
                    TextField(
                      style: body1.apply(),
                      controller: wefDateController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText:
                            'Enter when this ${cashflowType.first} takes effect',
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
                    // Amount
                    TextField(
                      controller: amountController,
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
                        hintText: 'Enter the ${cashflowType.first} amount',
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
                    TextField(
                      style: body1.apply(),
                      controller: colorController,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (int.tryParse(
                              value.substring(1),
                              radix: 16,
                            ) !=
                            null) {
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        prefix: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Color(int.parse(
                                    colorController.text.substring(1),
                                    radix: 16,
                                  ) +
                                  0xFF000000),
                            ),
                          ),
                        ),
                        hintText:
                            'Provide a color for this ${cashflowType.first}',
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
                          await recurrentCashflowsColl.add(
                            RecurrentCashflow(
                              name: nameController.text,
                              amount: double.parse(amountController.text),
                              cashflowType: $enumDecode(
                                _$CashflowTypeEnumMap,
                                cashflowType.first.split('-').join(),
                              ),
                              frequency: $enumDecode(
                                _$RecurrenceFrequencyEnumMap,
                                recurrenceType.first,
                              ),
                              wefDate:
                                  DateUtils.fromDDMMYYYY(wefDateController.text)
                                      .millisecondsSinceEpoch,
                              color: colorController.text,
                            ),
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop();
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
}
