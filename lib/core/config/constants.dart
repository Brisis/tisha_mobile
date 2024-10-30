import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

abstract class AppUrls {
  static String SERVER_URL = "http://192.168.100.2:8000";
  // static String SERVER_URL = "http://192.168.1.230:8000";
}

class FileStorage {
  static Future<String> getExternalDocumentPath() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory _directory = Directory("dir");
    if (Platform.isAndroid) {
      _directory = Directory("/storage/emulated/0/Download/Tisha Reports");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    final String directory = await getExternalDocumentPath();
    return directory;
  }

  static Future<File> exportDataTableToExcel(
      List<List<String>> data, String fileNameOut) async {
    // Create a new Excel document
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Populate the sheet with data
    for (var row in data) {
      sheetObject.appendRow(row);
    }

    // Save the file to the documents directory
    // final directory = await getApplicationDocumentsDirectory();
    // final filePath = "${directory.path}/$fileName.xlsx";
    // final fileBytes = excel.save();

    // Generate a timestamp for the filename
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    String fileName = "${fileNameOut}_${timestamp.substring(0, 15)}.xlsx";
    String filePath = join(await _localPath, fileName);
    File file = File(filePath);
    final fileBytes = excel.save();

    try {
      if (await file.exists()) {
        // If the file exists, delete it before writing the new data
        await file.delete();
      }

      await file.writeAsBytes(Uint8List.fromList(fileBytes!), flush: true);
      print('Image saved to: $filePath');
      return file; // Move the return statement inside the try block
    } catch (e) {
      print('Error saving image: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }

  static Future<File> downloadAndSaveImage(String url) async {
    var response = await http.get(Uri.parse(url));
    Uint8List bytes = response.bodyBytes;

    // Generate a timestamp for the filename
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    String fileName = '$timestamp' + '_' + basename(url);
    String filePath = join(await _localPath, fileName);
    File file = File(filePath);

    try {
      if (await file.exists()) {
        // If the file exists, delete it before writing the new data
        await file.delete();
      }

      await file.writeAsBytes(bytes, flush: true);
      print('Image saved to: $filePath');
      return file; // Move the return statement inside the try block
    } catch (e) {
      print('Error saving image: $e');
      throw e; // Rethrow the exception to handle it elsewhere if needed
    }
  }
}
