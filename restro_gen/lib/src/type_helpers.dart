import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'annotation_helpers.dart';
import 'restro_gen_config.dart';
import 'utils.dart';
import 'method_code_builder.dart';

abstract class TypeHelpers {
  static Class buildClass(ClassElement classElement) {
    final classSourceBuilder = ClassBuilder();
    classSourceBuilder.name = '_\$${classElement.name}Impl';
    classSourceBuilder.extend = refer(classElement.displayName);
    String urlPrefix = AnnotationHelpers.processClassAnnotation(classElement);
    for (MethodElement methodElement in classElement.methods) {
      classSourceBuilder.methods.add(buildMethod(urlPrefix, methodElement));
    }
    return classSourceBuilder.build();
  }

  static Method buildMethod(String urlPrefix, MethodElement methodElement) {
    RestroGenConfig config = RestroGenConfig(url: urlPrefix);
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
    methodBuilder.body =
        Block.of(MethodCodeBuilder.buildCodeFromConfig(config));
    return methodBuilder.build();
  }

  static Parameter buildParameter(
      RestroGenConfig config, ParameterElement parameterElement) {
    var parameterBuilder = ParameterBuilder();
    parameterBuilder.name = parameterElement.name;
    parameterBuilder.type = refer(parameterElement.type.displayName);
    bool isAnnotationProcessed =
        AnnotationHelpers.processMethodParamPathAnnotation(
            config, parameterElement);
    if (isAnnotationProcessed == false) {
      isAnnotationProcessed = AnnotationHelpers.processQueryParamAnnotation(
          config, parameterElement);
    }

    return parameterBuilder.build();
  }
}
