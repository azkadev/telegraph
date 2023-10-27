import 'dart:io';

import 'package:telegraph/telegraph.dart';
import 'package:telegraph/telegraph_core.dart';
import "package:general_lib/general_lib.dart";

void main(List<String> arguments) async {
  Telegraph telegraph = Telegraph();

  var res = await telegraph.createAccount(
    short_name: "salsa",
    author_name: "sas"
   );

  res.printPretty();

  exit(0);
}
