import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'Word_States.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//TickerProviderStateMixin help to create or biuld
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => Word_State_Screen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //animation
            AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 250,
                width: 250,
                child: const Center(
                  child: Image(image: AssetImage('assets/images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            const Align(
              alignment: Alignment.center,
              child: Text(
                "  Covid-19 \nTracker App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            )
          ],
        ),
      ),
    );
  }
}
