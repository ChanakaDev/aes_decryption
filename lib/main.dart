// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:encrypt/encrypt.dart' as enc;

String mykey = 'd660370f115b55cb48a79c43aabb6e47';
String myiv = '2d07b0fb33362b5b';

final keyUtf8 = utf8.encode(mykey);
final ivUtf8 = utf8.encode(myiv);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final key = sha256.convert(keyUtf8).toString().substring(0, 32);
  final iv = sha256.convert(ivUtf8).toString().substring(0, 16);

  // variables to hold plain text and the chipher text
  String _encyrptedString = '';
  String _decryptedString = '';

  // Method to encypt data
  Future<void> encryptingData() async {
    String encryptedText;

    try {
      // Encryption
      String plainText = 'Chanaka';
      final encrypter =
          enc.Encrypter(enc.AES(Key.fromUtf8(key), mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: IV.fromUtf8(iv));
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
          enc.Encrypter(enc.AES(Key.fromUtf8(key), mode: AESMode.cbc));
      final decrypted = decrypter
          .decryptBytes(Encrypted.fromBase64(chipherText), iv: IV.fromUtf8(iv));
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

              // Button to decrypt the data
              ElevatedButton(
                onPressed: () async {
                  await dencryptingData("6mUhaDY5oDecoMYX3eWZag==");
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
