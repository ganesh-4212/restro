import 'enums.dart';

class RestroConfig {
  RequestMethod method;
  String url;
  Map<String, String> headers = {};
  Map<String, String> queryParams = {};
  bool isMultiPart;
  bool isFormUrlEncoded;
  dynamic body;

  RestroConfig(
      {this.method,
      this.url,
      this.headers,
      this.queryParams,
      this.isMultiPart,
      this.isFormUrlEncoded,
      this.body});


}
