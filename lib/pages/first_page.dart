import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:foodgame/pages/second_page.dart';


class FirstPage extends StatelessWidget {
  static String first_page = '/';

  AudioPlayer player = AudioPlayer();


  void _playSound(String soundPath) async {
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/firstpageog.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.295,
                // left: constraints.maxWidth * 0.455,
                right: constraints.maxWidth * 0.100,

                child: GestureDetector(
                  onTap: () {
                    _playSound('buttonclickevent.mp3');
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SecondPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/Asset2@3x.png',
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxHeight * 0.08,
                    fit: BoxFit.fill,
                  ),
                ),

              ),
                AnimatedCloudSequence(
            duration:const Duration(seconds: 30),
            cloudImagePaths:const [
              'assets/Asset15@3x.png',
              'assets/Asset15@3x.png', 
            ],
          ),


            ],
          );
        },
      ),
    );
  }
}


class AnimatedCloudSequence extends StatefulWidget {
  final Duration duration;
  final List<String> cloudImagePaths;

  AnimatedCloudSequence({
    required this.duration,
    required this.cloudImagePaths,
  });

  @override
  _AnimatedCloudSequenceState createState() => _AnimatedCloudSequenceState();
}

class _AnimatedCloudSequenceState extends State<AnimatedCloudSequence>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<double> _cloudPositions;

  @override
  void initState() {
    super.initState();
    _cloudPositions = List.generate(widget.cloudImagePaths.length,
        (index) => -200.0 - (index * 200.0)); // Increased vertical spacing
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
      setState(() {
        for (int i = 0; i < _cloudPositions.length; i++) {
          _cloudPositions[i] =
              (_cloudPositions[i] + 1) % (MediaQuery.of(context).size.width + 200);
        }
      });
    });
    _startAnimation();
  }

  void _startAnimation() {
    _controller.repeat(); // Create a continuous looping animation
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _cloudPositions.length; i++)
          Positioned(
            top: 1 + i * 170.0, 
            left: _cloudPositions[i],
            child: Image.asset(
              widget.cloudImagePaths[i],
              width: 200, // Adjust the width as needed
              height: 150.0, // Adjust the height as needed
              fit: BoxFit.fill,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



