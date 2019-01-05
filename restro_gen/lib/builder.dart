import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:restro_gen/src/web_api_generator.dart';

Builder webApi(BuilderOptions options) {
  return SharedPartBuilder([WebApiGenerator()], 'web_api');
}
