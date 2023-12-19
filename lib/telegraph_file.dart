import 'dart:io';
import 'dart:typed_data';
 
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class TelegraphFileData {
  final Uint8List bytes;
  final String name;
  final String mime;
  TelegraphFileData({
    required this.bytes,
    required this.name,
     this.mime = "application/text",
  });

  static TelegraphFileData fromFile({required File file}) {
    return TelegraphFileData(
      bytes: file.readAsBytesSync(),
      name: basename(file.path),
      mime: (lookupMimeType(basename(file.path)) ?? "application/text"),
    );
  }
}
