// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:telegraph/telegraph.dart';
import 'package:telegraph/telegraph_core.dart';
import "package:general_lib/general_lib.dart";

void main(List<String> arguments) async {
  Telegraph telegraph = Telegraph();

  var res = await telegraph.createAccount(
    short_name: "salpsalpsplas",
    author_name: "Sasasasa",
  );

  res.printPretty();

  exit(0);
}
