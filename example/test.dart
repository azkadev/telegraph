import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> uploadImage(String imagePath) async {
  final url = Uri.parse('https://telegra.ph/upload');

  // Buka file gambar
  final imageFile = File(imagePath);
  if (!await imageFile.exists()) {
    print('File tidak ditemukan: $imagePath');
    return;
  }

  // Persiapkan multipart request
  final request = http.MultipartRequest('POST', url)
    ..files.add(
      http.MultipartFile(
        'file', // Field name
        imageFile.openRead(),
        imageFile.lengthSync(),
        filename: imageFile.path.split('/').last,
      ),
    );

  try {
    // Kirim request
    final response = await request.send();

    // Baca response
    final responseBody = await response.stream.bytesToString();
    final jsonResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      print('Upload berhasil: $jsonResponse');
    } else {
      print('Upload gagal: ${response.statusCode}');
      print('Pesan: $jsonResponse');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}

void main(List<String> args) async {
  final String imagePath =
      "/home/galaxeus/Pictures/Karma-Kaveya-The-All-Electric-GT-Revolutionizing-Ultra-Luxury-3.jpg";
  await uploadImage(imagePath);
}
