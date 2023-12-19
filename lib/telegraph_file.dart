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
