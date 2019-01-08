import 'restro_gen_config.dart';

abstract class Utils {
  static void buildUrlFromPathParameter(RestroGenConfig config) {
    String replacedUrl = config.url;
    config.parameterPathMap.forEach((pathName, parameterName) {
      replacedUrl = replacedUrl.replaceAll(':$pathName', '\$$parameterName');
    });
    config.url = replacedUrl;
  }
}
