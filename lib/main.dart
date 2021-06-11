import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset(
    'assets/Milky-Way.jpg',
    fit: BoxFit.fill,
  );
  final Image ufo = Image.asset(
    'assets/ufo.png',
  );
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animation"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/Milky-Way.jpg",
              ),
              fit: BoxFit.fill),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) {
                return ClipPath(
                  clipper: const BeamClipper(),
                  child: Container(
                    height: 1000,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 1.5,
                        colors: [
                          Colors.yellow,
                          Colors.transparent,
                        ],
                        stops: [0, _animation.value],
                      ),
                    ),
                  ),
                );
              },
            ),
            ufo,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
