part of 'package:hauberk/main.dart';

class HauberkApi {
  static const String apiName = 'hauberk-api';
  static const String apiHost =
      'hauberk-server-975804516663.us-central1.run.app';

  static final hauberkApiRevolutCreateConsent =
      HauberkApiRevolutCreateConsentEndpoint();
}

class HauberkApiRevolutCreateConsentEndpoint {
  Future<http.Response> post({
    required ({
      String redirectUri,
    }) queryParameters,
  }) async {
    return await http.post(
      Uri.https(
        'hauberk-server-975804516663.us-central1.run.app',
        '/revolut/createConsent',
        {
          'redirectUri': queryParameters.redirectUri,
        },
      ),
    );
  }
}
