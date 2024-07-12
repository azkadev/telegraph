/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class TelegraphFileData {
  final Uint8List file_bytes;
  final String file_name;
  final String file_mime;
  TelegraphFileData({
    required this.file_bytes,
    required this.file_name,
    this.file_mime = "application/document",
  });

  static TelegraphFileData file(
    File fileData,
  ) {
    return TelegraphFileData(
      file_bytes: fileData.readAsBytesSync(),
      file_name: basename(fileData.path),
      file_mime:
          (lookupMimeType(basename(fileData.path)) ?? "application/document"),
    );
  }

  static TelegraphFileData bytes(
    Uint8List fileBytes,
  ) {
    return TelegraphFileData(
      file_bytes: fileBytes,
      file_name: "blob",
    );
  }

  static Future<TelegraphFileData> network(
    String url, {
    Client? httpClient,
  }) async {
    httpClient ??= Client();

    Response response = await httpClient.get(Uri.parse(url));

    return TelegraphFileData(
      file_bytes: response.bodyBytes,
      file_name: "blob",
    );
  }
}
