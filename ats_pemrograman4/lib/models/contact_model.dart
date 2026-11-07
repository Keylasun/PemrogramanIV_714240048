import 'dart:typed_data';
import 'package:flutter/material.dart';

/// Model data kontak dengan dukungan preview gambar
class ContactModel {
  String name;
  String phoneNumber;
  DateTime date;
  Color color;
  String fileName;
  String? filePath;
  Uint8List? fileBytes;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.color,
    required this.fileName,
    this.filePath,
    this.fileBytes,
  });

  /// Cek apakah file adalah gambar (JPG, JPEG, PNG)
  bool get isImageFile {
    final ext = fileName.toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png');
  }

  /// Copy model dengan data baru
  ContactModel copyWith({
    String? name,
    String? phoneNumber,
    DateTime? date,
    Color? color,
    String? fileName,
    String? filePath,
    Uint8List? fileBytes,
  }) {
    return ContactModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      date: date ?? this.date,
      color: color ?? this.color,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileBytes: fileBytes ?? this.fileBytes,
    );
  }
}

