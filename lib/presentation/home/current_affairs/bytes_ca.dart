import 'package:exampur_mobile/presentation/widgets/byte_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BytesCA extends StatefulWidget {
  @override
  _BytesCAState createState() => _BytesCAState();
}

class _BytesCAState extends State<BytesCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ByteSlider());
  }
}
