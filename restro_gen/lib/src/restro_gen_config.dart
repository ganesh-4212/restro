import 'package:restro/restro.dart';
class RestroGenConfig {
  RequestMethod method;
  String url;
  Map<String,String> methodHeaders = {};
  Map<String,String> parameterPathMap = {};
  Map<String,String> queryMap = {};
  RestroGenConfig({this.method=RequestMethod.GET, this.url=''});
  
}

