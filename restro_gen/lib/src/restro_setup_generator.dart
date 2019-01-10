import 'dart:async';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';

import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'type_helpers.dart';
import 'package:restro/restro.dart';

class RestroSetupGenerator extends GeneratorForAnnotation<RestroSetup> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final library = TypeHelpers.processRestroSetup(element);
    final emitter = DartEmitter();
    return DartFormatter().format('${library.accept(emitter)}');
  }
}
