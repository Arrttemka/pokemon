import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageCacheService {
  Future<String?> cacheImageFromUrl(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/pokemon_images';

      await Directory(filePath).create(recursive: true);

      final file = File('$filePath/$fileName');

      if (await file.exists()) {
        return file.path;
      }

      try {
        final response = await http.get(Uri.parse(url))
            .timeout(const Duration(seconds: 5));

        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          return file.path;
        }
        return null;
      } catch (_) {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<bool> doesImageExist(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/pokemon_images/$fileName';
      return await File(filePath).exists();
    } catch (_) {
      return false;
    }
  }

  Future<String?> getLocalImagePath(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/pokemon_images/$fileName';

      if (await File(filePath).exists()) {
        return filePath;
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}