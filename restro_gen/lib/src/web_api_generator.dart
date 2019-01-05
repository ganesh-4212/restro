import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'type_helpers.dart';

import 'package:todo_reporter/todo_reporter.dart';

class WebApiGenerator extends GeneratorForAnnotation<WebApi> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      final builtClass = TypeHelpers.buildClass(element);
      final emitter = DartEmitter();
      return DartFormatter().format('${builtClass.accept(emitter)}');
    }
    return '';
  }
}
