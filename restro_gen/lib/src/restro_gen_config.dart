import 'package:restro/restro.dart';
class RestroGenConfig {
  RequestMethod method;
  String url;
  Map<String,String> methodHeaders = {};
  RestroGenConfig({this.method=RequestMethod.GET, this.url=''});
}

