# Telegraph libray

## Install library
```bash
dart pub add telegraph
```

## Import library
```dart
import 'package:telegraph/telegraph.dart'; 
```


## Quickstart
```dart
// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:telegraph/telegraph.dart'; 
void main(List<String> arguments) async {
  Telegraph telegraph = Telegraph();
  var res = await telegraph.createAccount(
    short_name: "salpsalpsplas",
    author_name: "Sasasasa",
  );
  print(res);
  exit(0);
}
```