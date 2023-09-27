// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class CounterStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     print("directory  $directory");
//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     final path = await _localPath;
//     print("directory  $path");

//     return File('$path/counter.txt');
//   }

//   Future<String> readFingerPrint() async {
//     try {
//       final file = await _localFile;

//       // Read the file
//       final contents = await file.readAsString();

//       return contents;
//     } catch (e) {
//       print("error $e");
//       return "";
//     }
//   }

//   Future<File> writeCounter(String fp) async {
//     final file = await _localFile;

//     // Write the file
//     return file.writeAsString('$fp');
//   }
// }
