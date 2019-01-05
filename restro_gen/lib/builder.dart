import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:restro_gen/src/restro_gen.dart';
import 'package:restro_gen/src/web_api_generator.dart';

Builder todoReporter(BuilderOptions options) =>
    SharedPartBuilder([TodoReporterGenerator()], 'todo_reporter');

Builder webApi(BuilderOptions options) {
  return SharedPartBuilder([WebApiGenerator()], 'web_api');
}
