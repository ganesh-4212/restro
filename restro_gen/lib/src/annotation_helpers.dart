import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart' show DartObject;
import 'package:source_gen/source_gen.dart';
import 'package:restro/restro.dart';
import 'restro_gen_config.dart';

abstract class AnnotationHelpers {
  static const TypeChecker _registerGetTC = const TypeChecker.fromRuntime(GET);
  static const TypeChecker _registerPostTc =
      const TypeChecker.fromRuntime(POST);
  static const REQUEST_METHOD_URL_PROP = 'value';
  static void processMethodAnnotations(
      RestroGenConfig config, MethodElement methodElement) {
    processRequestMethodAnnotations(config, methodElement);
  }

  static bool isGet(MethodElement methodElement) {
    return _registerGetTC.hasAnnotationOfExact(methodElement);
  }

  static bool isPost(MethodElement methodElement) {
    return _registerPostTc.hasAnnotationOfExact(methodElement);
  }

  static void processRequestMethodAnnotations(
      RestroGenConfig config, MethodElement methodElement) {
    DartObject annotationObject;
    if (isGet(methodElement)) {
      annotationObject = _registerGetTC.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.GET;
    } else if (isPost(methodElement)) {
      annotationObject = _registerPostTc.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.POST;
    }
    config.url =
        annotationObject.getField(REQUEST_METHOD_URL_PROP).toStringValue();
  }
}
