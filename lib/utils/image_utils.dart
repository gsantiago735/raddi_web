/*import 'dart:io';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:pcb/models/generic/photo_model.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtils {
  static Future<void> getImageFromCamera({
    required void Function(PhotoModel) onGetImage,
    void Function(String)? onError,
    List<String> allowedExtensions = const ["jpg", "jpeg", "png", "heic"],
  }) async {
    try {
      final cameraPermissionStatus = await Permission.camera.status;

      // Validando permisos del dispositivo para la cámara
      if (cameraPermissionStatus.isGranted) {
        final xfile = await ImagePicker().pickImage(source: ImageSource.camera);

        // Evaluando si un archivo ha sido seleccionado
        if (xfile != null) {
          log("Path: ${xfile.path}");
          final fileExtension = xfile.path.split('.').last.toLowerCase();

          // Validando extensión del archivo
          if (allowedExtensions.contains(fileExtension)) {
            final photo = PhotoModel(
              file: File(xfile.path),
              id: DateTime.now().toIso8601String(),
            );
            // Enviando objeto por parámetro
            onGetImage(photo);
          } else {
            if (onError != null) onError("Extensión no permitida.");
          }
        }
      } else {
        // Solicitando permisos de la cámara
        final permission = await Permission.camera.request();

        if (permission.isGranted) {
          getImageFromCamera(
            onGetImage: onGetImage,
            onError: onError,
            allowedExtensions: allowedExtensions,
          );
        } else {
          // Los permisos no han sido aprobados
          if (onError != null) onError("No se concede el permiso de cámara.");
        }
      }
    } catch (e) {
      if (onError != null) onError(e.toString());
    }
  }

  static Future<void> getImageFromGallery({
    required void Function(PhotoModel) onGetImage,
    void Function(String)? onError,
    List<String> allowedExtensions = const ["jpg", "jpeg", "png", "heic"],
  }) async {
    try {
      // Verificando permisos de almacenamiento
      final storagePermission = await Permission.storage.status;
      if (!storagePermission.isGranted) {
        final storagePermissionRequest = await Permission.storage.request();
        if (!storagePermissionRequest.isGranted) {
          if (onError != null) {
            onError("No se concede el permiso de almacenamiento.");
          }
          return;
        }
      }

      // Selección de imagen desde la galería
      final xfile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (xfile != null) {
        log("Path: ${xfile.path}");
        final fileExtension = xfile.path.split('.').last.toLowerCase();

        // Validando extensión del archivo
        if (allowedExtensions.contains(fileExtension)) {
          final photo = PhotoModel(
            file: File.fromUri(Uri(path: xfile.path)),
            id: DateTime.now().toIso8601String(),
          );
          // Enviando objeto por parámetro
          onGetImage(photo);
        } else {
          if (onError != null) onError("Extensión no permitida.");
        }
      }
    } catch (e) {
      if (onError != null) onError(e.toString());
    }
  }
}
*/
