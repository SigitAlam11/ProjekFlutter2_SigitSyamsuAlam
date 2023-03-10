import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageScreenView extends StatelessWidget {
  const ImageScreenView({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Image.network(
            imageUrl,
            height: 700,
          ),
          BackButton(),
        ]),
      ),
    );
  }
}
