part of 'package:hauberk/main.dart';

class AddAccountForm extends StatefulWidget {
  final bool externalAccount;

  const AddAccountForm({required this.externalAccount, super.key});

  @override
  State<StatefulWidget> createState() => AddAccountFormState();
}

class AddAccountFormState extends State<AddAccountForm> {
  final TextEditingController nameController = TextEditingController();
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
                      hintText: 'Enter the account name',
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
                      hintText: 'Enter the starting balance',
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
                        if (!widget.externalAccount) {
                          await accountsColl.add(
                            Account(
                              name: nameController.text,
                              balance: double.parse(amountController.text),
                              ownerId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                        } else {
                          await externalAccountsColl.add(
                            Account(
                              name: nameController.text,
                              balance: double.parse(amountController.text),
                              ownerId: '',
                            ),
                          );
                        }

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
    );
  }
}
