import 'dart:math' as math;

import 'package:flutter/material.dart';

///Entry the application
void main() {
  runApp(const MyApp());
}

///MyApp
class MyApp extends StatelessWidget {
  /// Creates an instance of MyApp.
  const MyApp({super.key});

  /// Material App
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Background Color',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tap For a Random Color'),
    );
  }
}

/// A Statefull widget
class MyHomePage extends StatefulWidget {
  /// The title shown in the app bar.
  final String title;

  /// Creates an instance of MyHomePage with the title.
  const MyHomePage({required this.title, super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _backgroundColor = Colors.white;
  Color _appBarColor = Colors.white;
  Color _appBarTextColor = Colors.black;
  Color _backgroundTextColor = Colors.black;
  final randomGenerator = math.Random();

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        randomGenerator.nextInt(256),
        randomGenerator.nextInt(256),
        randomGenerator.nextInt(256),
      );
      _appBarColor = Color.fromARGB(
        255,
        randomGenerator.nextInt(256),
        randomGenerator.nextInt(256),
        randomGenerator.nextInt(256),
      );

      final double luminance = _backgroundColor.computeLuminance();
      _appBarTextColor = luminance < 0.5 ? Colors.white : Colors.black;
      _backgroundTextColor = luminance < 0.5 ? Colors.white : Colors.black;
    });
  }

  String colorToHex(Color color) {
    return '#'
            '${(color.a * 255).toInt().toRadixString(16).padLeft(2, '0')}'
            '${(color.r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
            '${(color.g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
            '${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return GestureDetector(
      onTap: _changeBackgroundColor,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            color: _appBarColor,
            child: AppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: _appBarTextColor),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          color: _backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: const Alignment(0, -0.2),
                child: Text(
                  'Hello there',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: _backgroundTextColor,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight / 2 + screenHeight * 0.08,
                left: screenWidth * 0.2,
                right: screenWidth * 0.2,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Background Color:',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RGB(${(_backgroundColor.r * 255).toInt()}, ${(_backgroundColor.g * 255).toInt()}, ${(_backgroundColor.b * 255).toInt()})',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        colorToHex(_backgroundColor),
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'AppBar Color:',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RGB(${(_appBarColor.r * 255).toInt()}, ${(_appBarColor.g * 255).toInt()}, ${(_appBarColor.b * 255).toInt()})',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        colorToHex(_appBarColor),
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
