part of 'package:hauberk/main.dart';

Future<void> requestAccountConsent() async {
  final res = await HauberkApi.hauberkApiRevolutCreateConsent.post(
    queryParameters: (redirectUri: Uri.base.toString()),
  );
  print(res.statusCode);
  print(res.body);
}
