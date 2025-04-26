import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_tap_color_changer/constants/app_constants.dart';


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
  /// Private variables 
  Color _backgroundColor = Colors.white;
  Color _appBarColor = Colors.white;
  Color _appBarTextColor = Colors.black;
  Color _backgroundTextColor = Colors.black;
  /// Instance of dart's random class used for generating random rgb values.
  final randomGenerator = math.Random();

  /// Randomly generates new colors and ajusts text color based on luminance.
  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        maxColorValue,
        randomGenerator.nextInt(maxColorValue),
        randomGenerator.nextInt(maxColorValue),
        randomGenerator.nextInt(maxColorValue),
      );
      _appBarColor = Color.fromARGB(
        maxColorValue,
        randomGenerator.nextInt(maxColorValue),
        randomGenerator.nextInt(maxColorValue),
        randomGenerator.nextInt(maxColorValue),
      );

      final double luminance = _backgroundColor.computeLuminance();
      _appBarTextColor = luminance < luminanceLevel ? Colors.white : Colors.black;
      _backgroundTextColor = luminance < luminanceLevel ? Colors.white : Colors.black;

    });
  }

  /// Converts a color into a HEX string.
  String colorToHex(Color color) {
    return '#'
        '${(color.alpha * maxColorValue).toRadixString(hexaDec).padLeft(absoluteTwo, '$absoluteZero')}'
        '${(color.red * maxColorValue).toRadixString(hexaDec).padLeft(absoluteTwo, '$absoluteZero')}'
        '${(color.green * maxColorValue).toRadixString(hexaDec).padLeft(absoluteTwo, '$absoluteZero')}'
        '${(color.blue * maxColorValue).toRadixString(hexaDec).padLeft(absoluteTwo, '$absoluteZero')}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    /// To get the screen sizes of the device.
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
            duration: const Duration(milliseconds: animationDurationMs),
            curve: Curves.easeInOut,
            color: _appBarColor,
            child: AppBar(
              title: Text(
                widget.title,
                style: TextStyle(color: _appBarTextColor),
              ),
              backgroundColor: Colors.transparent,
              elevation: absoluteZero.toDouble(),
              centerTitle: true,
            ),
          ),
        ),
        body: AnimatedContainer(
          duration: const Duration(milliseconds: animationDurationMs),
          curve: Curves.easeInOut,
          color: _backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment(absoluteZero.toDouble(), helloTextVerticalOffset),
                child: Text(
                  'Hello there',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * fontSizeLarge,
                    color: _backgroundTextColor,
                  ),
                ),
              ),
              Positioned(
                top: screenHeight / absoluteTwo + screenHeight * infoBoxTopOffset,
                left: screenWidth * infoBoxPadding,
                right: screenWidth * infoBoxPadding,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * paddingVertical,
                    horizontal: screenWidth * paddingHorizontal,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(infoBoxBorderRadius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Background Color:',
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: smallSpacing),
                      Text(
                        'RGB(${(_backgroundColor.r * maxColorValue).toInt()}, ${(_backgroundColor.g * maxColorValue).toInt()}, ${(_backgroundColor.b * maxColorValue).toInt()})',
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeSmall,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        colorToHex(_backgroundColor),
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeSmall,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: mediumSpacing),
                      Text(
                        'AppBar Color:',
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeMedium,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: smallSpacing),
                      Text(
                        'RGB(${(_appBarColor.r * maxColorValue).toInt()}, ${(_appBarColor.g * maxColorValue).toInt()}, ${(_appBarColor.b * maxColorValue).toInt()})',
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeSmall,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        colorToHex(_appBarColor),
                        style: TextStyle(
                          fontSize: screenWidth * fontSizeSmall,
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
