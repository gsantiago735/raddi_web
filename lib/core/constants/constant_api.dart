class ConstantApi {
  // Url Prod
  static const String urlBaseProd = "https://raddiglobal.online/prod/";
  // Url Dev
  static const String urlBaseDev = 'https://raddiglobal.online/dev/';
  // Url Local
  static const String urlBaseLocal = 'http://192.168.1.109:5000/';

  // =========================================================================
  // Change url with the current environment if necessary
  // =========================================================================

  static String url = urlBaseDev;
}
