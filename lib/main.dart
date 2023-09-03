// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:encrypt/encrypt.dart' as enc;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final key = enc.Key.fromUtf8('d660370f115b55cb48a79c43aabb6e47');
  final iv = enc.IV.fromUtf8('2d07b0fb33362b5b');

  // variables to hold plain text and the chipher text
  String _encyrptedString = '';
  String _decryptedString = '';

  // Method to encypt data
  Future<void> encryptingData() async {
    String encryptedText;

    try {
      // Encryption
      String plainText = 'Chanaka';
      final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      encryptedText = encrypted.base64;
    } on Exception catch (e) {
      encryptedText = e.toString();
    }

    setState(() {
      _encyrptedString = encryptedText;
    });
  }

  // Method to decrypt data
  Future<void> dencryptingData(
    String chipherText,
  ) async {
    String decryptedString;

    try {
      final decrypter =
          enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: null));
      final decrypted =
          decrypter.decryptBytes(Encrypted.from64(chipherText), iv: iv);
      decryptedString = utf8.decode(decrypted);
    } on Exception catch (e) {
      decryptedString = e.toString();
    }

    setState(() {
      _decryptedString = decryptedString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AesPack example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Button to encypt the data
              ElevatedButton(
                onPressed: () async {
                  await encryptingData();
                  print("Encrypted data: $_encyrptedString");
                },
                child: const Text("Encrypt Data"),
              ),

              // // Button to decrypt the data
              ElevatedButton(
                onPressed: () async {
                  await dencryptingData("u04le0BuDI/TqkTPhwRScA==");
                  print("Decrypted data: $_decryptedString");
                },
                child: const Text("Decrypt data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
