import 'enums.dart';

class RestroConfig {
  RequestMethod method;
  String url;
  Map<String, String> headers = {};
  Map<String, String> queryParams = {};
  Map<String, String> pathParams = {};
  bool isMultiPart;
  bool isFormUrlEncoded;
  dynamic body;

  RestroConfig(
      {this.method,
      this.url,
      this.headers,
      this.queryParams,
      this.pathParams,
      this.isMultiPart,
      this.isFormUrlEncoded,
      this.body});


}
