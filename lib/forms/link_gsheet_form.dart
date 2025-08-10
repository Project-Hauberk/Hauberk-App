part of 'package:hauberk/main.dart';

class LinkGsheetForm extends StatefulWidget {
  final AuthClient authClient;
  const LinkGsheetForm({
    required this.authClient,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => LinkGsheetFormState();
}

class LinkGsheetFormState extends State<LinkGsheetForm> {
  late final Future<drive.FileList> loadFiles =
      drive.DriveApi(widget.authClient)
          .files
          .list(q: "mimeType='application/vnd.google-apps.spreadsheet'");

  String? linkedGoogleSheetId;

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
                    // Gsheet Selector
                    FutureBuilder(
                      future: loadFiles,
                      builder: (ctx, snapshot) => snapshot.standardHandler(
                        () => DropdownMenu(
                          label: const Text('Select a spreadsheet'),
                          onSelected: (value) => linkedGoogleSheetId = value,
                          inputDecorationTheme: InputDecorationTheme(
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
                          dropdownMenuEntries: [
                            for (drive.File file
                                in snapshot.data?.files ?? const [])
                              DropdownMenuEntry(
                                value: file.id,
                                label:
                                    file.name ?? file.description ?? 'Unknown',
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          await profileDoc.update(
                              {'linkedGoogleSheet': linkedGoogleSheetId});
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
                              'Link',
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
