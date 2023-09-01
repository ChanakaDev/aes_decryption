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
  final String _text = 'Test';
  final String _key = '0102030405060708';
  final String _iv = '1112131415161718';
  String _encyrptedString = '';
  String _decryptedString = 'Unknown';

  @override
  void initState() {
    super.initState();
    initAesState();
  }

  Future<void> initAesState() async {
    String decryptedString;
    String text;

    try {
      text = await Aespack.encrypt(_text, _key, _iv) ?? '';
      decryptedString =
          await Aespack.decrypt(text, _key, _iv) ?? 'Failed to decrypt.';
    } on Exception {
      decryptedString = 'Failed to decrypt.';
      text = 'Failed to encrypt';
    }

    if (!mounted) return;

    setState(() {
      _decryptedString = decryptedString;
      _encyrptedString = text;
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
              Text('Text : $_text\n'),
              Text('Encrypted : $_encyrptedString\n'),
              Text('Decrypted : $_decryptedString\n'),
            ],
          ),
        ),
      ),
    );
  }
}
