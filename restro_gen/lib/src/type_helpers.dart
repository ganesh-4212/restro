import 'package:analyzer/dart/element/element.dart';
import 'package:built_collection/built_collection.dart';
import 'package:code_builder/code_builder.dart';
import 'annotation_helpers.dart';
import 'restro_gen_config.dart';
import 'utils.dart';
import 'method_code_builder.dart';

abstract class TypeHelpers {
  static Class buildClass(ClassElement classElement) {
    final classSourceBuilder = ClassBuilder();
    String implemetedClassName = _getImplementationClassName(classElement.name);
    classSourceBuilder.name = implemetedClassName;
    classSourceBuilder.extend = refer(classElement.displayName);

    ConstructorBuilder constructorBuilder = ConstructorBuilder();
    constructorBuilder.factory = true;
    constructorBuilder.lambda = true;
    constructorBuilder.body = Code("$implemetedClassName()");

    classSourceBuilder.constructors.add(constructorBuilder.build());
    String urlPrefix = AnnotationHelpers.processClassAnnotation(classElement);
    for (MethodElement methodElement in classElement.methods) {
      classSourceBuilder.methods.add(buildMethod(urlPrefix, methodElement));
    }
    return classSourceBuilder.build();
  }

  static String _getImplementationClassName(String className) =>
      '_\$${className}Impl';

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

  static Library processRestroSetup(Element element) {
    Map<String, String> classNameConstructorMap = {};

    String elementName = "_\$${element.name}";

    AnnotationHelpers.processRestroSetup(element).forEach((item) {
      final className = item.toTypeValue().name;
      classNameConstructorMap[className] = "$className()";
    });
    String codeString = "Restro $elementName = Restro()";
    classNameConstructorMap.forEach((key, value) {
      codeString += "..registerService<$key>($key, $value)";
    });
    final library = Library((b) => b.body.add(Code("$codeString;")));

    return library;
  }
}
