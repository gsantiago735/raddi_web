import 'package:dio/dio.dart';

class DataException implements Exception {
  const DataException({this.details, this.exception});

  final String? details;
  final DioException? exception;

  // Get error details
  String get getDescription {
    if ((details ?? "").isNotEmpty) return details!;

    if (exception != null) {
      // if the request can't reach to the HTTP server
      if (exception?.response == null) {
        return '''Verifica la configuración de tu red y asegúrate de que el '''
            '''Wi-Fi o los datos móviles estén activados.''';
      }

      // if the request can reach to the HTTP server
      try {
        // Error no capturado
        if (exception?.response?.data is String) {
          return "Ha ocurrido un error (E.${exception?.response?.statusCode}).";
        }

        // Error capturado
        return (exception?.response?.data["detail"]).toString();
      } catch (e) {
        return "Ha ocurrido un error (catch).";
      }
    }

    // Default
    return "Ha ocurrido un error desconocido.";
  }

  // Get error title
  String get getTitle {
    final int statusCode = exception?.response?.statusCode ?? -1;

    if (statusCode >= 100 && statusCode < 200) {
      return 'La operación se ha realizado con éxito';
    } else if (statusCode >= 200 && statusCode < 300) {
      return 'La solicitud se ha completado satisfactoriamente';
    } /*else if (statusCode >= 300 && statusCode < 400) {
      message = 'Ha ocurrido un error inesperado';
    }*/
    else if (statusCode >= 400 && statusCode < 500) {
      return 'La solicitud no pudo ser procesada';
    } else if (statusCode >= 500 && statusCode < 600) {
      return 'Ha ocurrido un error en el servidor';
    } else {
      return 'Ha ocurrido un error inesperado';
    }
  }
}
