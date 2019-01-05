import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';

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
    var methodBuilder = MethodBuilder();
    methodBuilder.name = methodElement.name;
    print("***********************Annotations************************");
    for (ElementAnnotation elementAnnotation in methodElement.metadata) {
      processMethodAnnotation(elementAnnotation);
    }
    print("***********************Annotations END************************");
    for (ParameterElement parameterElement in methodElement.parameters) {
      methodBuilder.requiredParameters.add(buildParameter(parameterElement));
    }
    methodBuilder.annotations.add(CodeExpression(Code('override')));
    methodBuilder.returns = refer(methodElement.returnType.displayName);
    methodBuilder.body = Code("return 'hello';");
    return methodBuilder.build();
  }

  static Parameter buildParameter(ParameterElement parameterElement) {
    var parameterBuilder = ParameterBuilder();
    parameterBuilder.name = parameterElement.name;
    parameterBuilder.type = refer(parameterElement.type.displayName);
    //TODO add parameter annotations
    return parameterBuilder.build();
  }

  static void processMethodAnnotation(ElementAnnotation elementAnnotation) {
    print("elementAnnotation.constantValue : ${elementAnnotation.constantValue.getField('url').toStringValue()}");
    // print("elementAnnotation.context : ${elementAnnotation.context.name}");
    // print("elementAnnotation.source.fullName : ${elementAnnotation.source.fullName}");
    // print("elementAnnotation.element.name : ${elementAnnotation.element.name}");
    // print("elementAnnotation.element.displayName : ${elementAnnotation.element.displayName}");

  }
}
