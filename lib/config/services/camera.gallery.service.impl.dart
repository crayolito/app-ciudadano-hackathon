import 'package:app_hackaton/config/services/camera.gallety.service.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class CameraGalleryServiceImpl implements CameraGalleryService {
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    if (photo == null) return null;
    return photo.path;
  }

  static Future<String?> uploadImageToCloudinary(String filePath) async {
    final Dio dio = Dio();
    String url = 'https://api.cloudinary.com/v1_1/da9xsfose/image/upload';
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'upload_preset': 'fqw7ooma',
    });

    try {
      var response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        // Aquí puedes extraer la URL de la imagen de la respuesta
        // Por ejemplo: return response.data['secure_url'];
        return response.data['secure_url'].toString();
      } else {
        throw Exception(
            "Error al subir la imagen, código de estado: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al subir la imagen: $e");
    }
  }
}
