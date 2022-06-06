import 'package:smartplay/core/app_config.dart';

class Constants {
  static const String GET_TOKEN =
      AppConfig.app_endpoint_url + '/api/v1/auth/email';

  static const String VERIFY_TOKEN =
      AppConfig.app_endpoint_url + '/api/v1/auth/email/verify';

  static const String REGISTER =
      AppConfig.app_endpoint_url + '/api/v1/auth/register';

  static const String LOGIN = AppConfig.app_endpoint_url + '/api/v1/auth/login';

  static const String DASHBOARD =
      AppConfig.app_endpoint_url + '/api/v1/auth/login';

  // static const String LOGIN = AppConfig.app_endpoint_url + '/api/auth/login';

  // static const String VERIFY_OTP =
  //     AppConfig.app_endpoint_url + '/api/auth/verification/email/verify';
}
