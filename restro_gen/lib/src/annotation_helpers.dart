import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart' show DartObject;
import 'package:source_gen/source_gen.dart';
import 'package:restro/restro.dart';
import 'restro_gen_config.dart';

abstract class AnnotationHelpers {
  static const TypeChecker _registerWebApiTc =
      const TypeChecker.fromRuntime(WebApi);
  static const TypeChecker _registerGetTC = const TypeChecker.fromRuntime(GET);
  static const TypeChecker _registerPostTc =
      const TypeChecker.fromRuntime(POST);
  static const TypeChecker _registerDeleteTc =
      const TypeChecker.fromRuntime(DELETE);
  static const TypeChecker _registerPutTc = const TypeChecker.fromRuntime(PUT);
  static const TypeChecker _registerHeadTc =
      const TypeChecker.fromRuntime(HEAD);
  static const TypeChecker _registerPatchTc =
      const TypeChecker.fromRuntime(PATCH);

  static const TypeChecker _registerHeadersTc =
      const TypeChecker.fromRuntime(Headers);

  static const TypeChecker _registerPathTc =
      const TypeChecker.fromRuntime(Path);

  static const TypeChecker _registerQueryTc =
      const TypeChecker.fromRuntime(Query);

  static const TypeChecker _registerRestroSetupTc = const TypeChecker.fromRuntime(RestroSetup);

  static const REQUEST_METHOD_URL_PROP = 'value';
  static const WEB_API_PROP_URL = 'url';
  static void processMethodAnnotations(
      RestroGenConfig config, MethodElement methodElement) {
    processRequestMethodAnnotations(config, methodElement);
    processMethodHeadersAnnotation(config, methodElement);
  }

  static bool isGet(MethodElement methodElement) {
    return _registerGetTC.hasAnnotationOfExact(methodElement);
  }

  static bool isPost(MethodElement methodElement) {
    return _registerPostTc.hasAnnotationOfExact(methodElement);
  }

  static bool isDelete(MethodElement methodElement) {
    return _registerDeleteTc.hasAnnotationOfExact(methodElement);
  }

  static bool isPut(MethodElement methodElement) {
    return _registerPutTc.hasAnnotationOfExact(methodElement);
  }

  static bool isHead(MethodElement methodElement) {
    return _registerHeadTc.hasAnnotationOfExact(methodElement);
  }

  static bool isPatch(MethodElement methodElement) {
    return _registerPatchTc.hasAnnotationOfExact(methodElement);
  }

  static String processClassAnnotation(ClassElement classElement) {
    final annotation = _registerWebApiTc.firstAnnotationOfExact(classElement);
    String url = annotation.getField(WEB_API_PROP_URL).toStringValue();
    return (url != null && url.isNotEmpty) ? url : null;
  }

  static void processMethodHeadersAnnotation(
      RestroGenConfig config, MethodElement methodElement) {
    if (_registerHeadersTc.hasAnnotationOfExact(methodElement)) {
      final annotations =
          _registerHeadersTc.firstAnnotationOfExact(methodElement);
      final headersMap =
          annotations.getField(REQUEST_METHOD_URL_PROP).toMapValue();
      headersMap.forEach((key, value) {
        String headerName = key.toStringValue();
        String headerValue = value.toStringValue();
        if (headerName != null &&
            headerName.isNotEmpty &&
            headerValue != null &&
            headerValue.isNotEmpty)
          config.methodHeaders[headerName] = headerValue;
      });
    }
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
    } else if (isDelete(methodElement)) {
      annotationObject =
          _registerDeleteTc.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.DELETE;
    } else if (isPut(methodElement)) {
      annotationObject = _registerPutTc.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.PUT;
    } else if (isPatch(methodElement)) {
      annotationObject = _registerPatchTc.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.PATCH;
    } else if (isHead(methodElement)) {
      annotationObject = _registerHeadTc.firstAnnotationOfExact(methodElement);
      config.method = RequestMethod.HEAD;
    }
    if (annotationObject != null) {
      final methodUrl =
          annotationObject.getField(REQUEST_METHOD_URL_PROP).toStringValue();
      if (methodUrl != null && methodUrl.isNotEmpty) {
        config.url += methodUrl;
      }
    }
  }

  static bool processMethodParamPathAnnotation(
      RestroGenConfig config, ParameterElement parameterElement) {
    if (_registerPathTc.hasAnnotationOfExact(parameterElement)) {
      final pathVariableValueObj = _registerPathTc
          .firstAnnotationOfExact(parameterElement)
          .getField(REQUEST_METHOD_URL_PROP);
      String parameterName = parameterElement.name;
      String pathVariableValue = parameterName;
      if (pathVariableValueObj != null &&
          pathVariableValueObj.toStringValue() != null &&
          pathVariableValueObj.toStringValue().isNotEmpty) {
        pathVariableValue = pathVariableValueObj.toStringValue();
      }
      if (parameterName != null && parameterName.isNotEmpty) {
        config.parameterPathMap[pathVariableValue] = parameterName;
        return true;
      }
    }
    return false;
  }

  static bool processQueryParamAnnotation(
      RestroGenConfig config, ParameterElement parameterElement) {
    String parameterName = parameterElement.name;
    String queryFieldName = parameterName;
    if (_registerQueryTc.hasAnnotationOfExact(parameterElement)) {
      final queryFieldObj = _registerQueryTc
          .firstAnnotationOfExact(parameterElement)
          .getField(REQUEST_METHOD_URL_PROP);

      if (queryFieldObj != null &&
          queryFieldObj.toStringValue() != null &&
          queryFieldObj.toStringValue().isNotEmpty) {
        queryFieldName = queryFieldObj.toStringValue();
      }
      if (parameterName != null && parameterName.isNotEmpty) {
        config.queryMap[queryFieldName] = parameterName;
        return true;
      }
    } else if (parameterElement.metadata.isEmpty) {
      config.queryMap[queryFieldName] = parameterName;
      return true;
    }
    return false;
  }
  static List<DartObject> processRestroSetup(Element element){
    List<DartObject> types = [];
    if(_registerRestroSetupTc.hasAnnotationOfExact(element)){
      final annotation = _registerRestroSetupTc.firstAnnotationOfExact(element);
     types =annotation.getField(REQUEST_METHOD_URL_PROP).toListValue();
    }
    return  types;
  }
}
