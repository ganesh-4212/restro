import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:restro/restro.dart';
import 'annotation_helpers.dart';
import 'restro_gen_config.dart';
import 'utils.dart';

abstract class TypeHelpers {
  static Class buildClass(ClassElement classElement) {
    final classSourceBuilder = ClassBuilder();
    classSourceBuilder.name = '_\$${classElement.name}Impl';
    classSourceBuilder.extend = refer(classElement.displayName);
    for (MethodElement methodElement in classElement.methods) {
      classSourceBuilder.methods.add(buildMethod(methodElement));
    }
    return classSourceBuilder.build();
  }

  static Method buildMethod(MethodElement methodElement) {
    RestroGenConfig config = RestroGenConfig();
    var methodBuilder = MethodBuilder();
    methodBuilder.name = methodElement.name;
    AnnotationHelpers.processMethodAnnotations(config, methodElement);
    for (ParameterElement parameterElement in methodElement.parameters) {
      methodBuilder.requiredParameters
          .add(buildParameter(config, parameterElement));
    }
    methodBuilder.annotations.add(CodeExpression(Code('override')));
    methodBuilder.returns = refer(methodElement.returnType.displayName);
    Utils.buildUrlFromPathParameter(config);
    //Get code array from config;
    List<Code> codes = [];
    codes.add(Code('RestroConfig config = RestroConfig();'));
    codes.add(Code('config.method = ${config.method};'));
    codes.add(Code('config.url = "${config.url}";'));
    config.methodHeaders.forEach((key, value) {
      codes.add(Code('config.headers["$key"] = "${value}";'));
    });
    methodBuilder.body = Block.of(codes);
    return methodBuilder.build();
  }

  static Parameter buildParameter(
      RestroGenConfig config, ParameterElement parameterElement) {
    var parameterBuilder = ParameterBuilder();
    parameterBuilder.name = parameterElement.name;
    parameterBuilder.type = refer(parameterElement.type.displayName);
    AnnotationHelpers.processMethodParamPathAnnotation(
        config, parameterElement);
    return parameterBuilder.build();
  }

  static void processMethodAnnotation(ElementAnnotation elementAnnotation) {
    print(
        "elementAnnotation.constantValues : ${elementAnnotation.constantValue.getField('value').toStringValue()} *****");
    print(
        "elementAnnotation.runtimeType : ${elementAnnotation.constantValue.type.name} *****");
    print(
        "elementAnnotation.runtimeType : ${elementAnnotation.runtimeType} *****");
    print(
        "elementAnnotation.source.fullName : ${elementAnnotation.source.fullName} *****");
    print(
        "elementAnnotation.element.name : ${elementAnnotation.element.name} *****");
    print(
        "elementAnnotation.element.displayName : ${elementAnnotation.element.displayName} *****");
    final getTypeChecker = TypeChecker.fromRuntime(GET);
  }
}
