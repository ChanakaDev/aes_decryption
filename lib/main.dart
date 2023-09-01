// ignore_for_file: avoid_print

import 'dart:async';

import 'package:aespack/aespack.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Symmetric key (for both encryption and decryption)
  final String _key = 'd660370f115b55cb48a79c43aabb6e47';
  // Initialization Vector
  // to ensure that the same plaintext,
  // when encrypted multiple times with the same key,
  // does not produce the same ciphertext
  final String _iv = '2d07b0fb33362b5b';

  // variables to hold plain text and the chipher text
  String _encyrptedString = '';
  String _decryptedString = '';

  // Method to encypt data
  Future<void> encryptingData(
    String plainText,
    String symmetricKey,
    String initializationVector,
  ) async {
    String encryptedText;

    try {
      encryptedText = await Aespack.encrypt(
              plainText, symmetricKey, initializationVector) ??
          '';
    } on Exception {
      encryptedText = 'Failed to encrypt';
    }

    setState(() {
      _encyrptedString = encryptedText;
    });
  }

  // Method to decrypt data
  Future<void> dencryptingData(
    String chipherText,
    String symmetricKey,
    String initializationVector,
  ) async {
    String decryptedString;

    try {
      decryptedString = await Aespack.decrypt(
              chipherText, symmetricKey, initializationVector) ??
          'Failed to decrypt.';
    } on Exception {
      decryptedString = 'Failed to decrypt.';
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
                  await encryptingData("Chanaka", _key, _iv);
                  print("Encrypted data: $_encyrptedString");
                },
                child: const Text("Encrypt Data"),
              ),

              // Button to decrypt the data
              ElevatedButton(
                onPressed: () async {
                  await dencryptingData(
                      "u04le0BuDI/TqkTPhwRScA==", _key, _iv);
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
