part of 'package:hauberk/main.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String generateId() => String.fromCharCodes(
      Iterable.generate(
        16,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

SemanticCode txnTypeToCode(TxnType txnType) => switch (txnType) {
      TxnType.inflow => SemanticCode.green,
      TxnType.outflow => SemanticCode.yellow,
      TxnType.transfer => SemanticCode.blue,
    };

extension SnapshotUtils on AsyncSnapshot {
  Widget standardHandler(Widget Function() builder) {
    switch (connectionState) {
      case ConnectionState.none:
      case ConnectionState.done:
        if (hasError) {
          final id = generateId();
          print('EXCEPTION $id:');
          print(error);
          print(stackTrace);
          return Material(
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                      'Exception occurred. See logs of exception #$id for details.'),
                ),
              ),
            ),
          );
        } else {
          return builder();
        }
      case ConnectionState.waiting:
      case ConnectionState.active:
        return const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
