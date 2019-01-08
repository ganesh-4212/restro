import 'package:code_builder/code_builder.dart';
import 'restro_gen_config.dart';

abstract class MethodCodeBuilder {
  static List<Code> buildCodeFromConfig(RestroGenConfig config) {
    List<Code> codes = [];
    codes.add(Code('RestroConfig config = RestroConfig();'));
    codes.add(Code('config.method = ${config.method};'));
    codes.add(Code('config.url = "${config.url}";'));
    buildCodeForHeaders(config, codes);
    buildCodeForQuery(config, codes);
    return codes;
  }

  static void buildCodeForHeaders(RestroGenConfig config, List<Code> codes) {
    config.methodHeaders.forEach((key, value) {
      codes.add(Code('config.headers["$key"] = "${value}";'));
    });
  }

  static void buildCodeForQuery(RestroGenConfig config, List<Code> codes) {
    config.queryMap.forEach((key, value) {
      codes.add(Code('config.queryParams["$key"] = ${value};'));
    });
  }
}
