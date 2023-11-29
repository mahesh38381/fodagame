import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:foodgame/pages/third_page.dart';

// ignore: must_be_immutable
class SecondPage extends StatelessWidget {
  static String second_page = 'game/second_page';

  AudioPlayer player = AudioPlayer();


  void _playSound(String soundPath) async {
    await player.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/children_makeover_without_dosa.png'),
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
                top: screenHeight * 0.57,
                left: screenWidth * 0.34,
                child: GestureDetector(
                  onTap: () {
                    _playSound('buttonclickevent.mp3');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdPage(
                          onPageRefresh: () {},
                        ),
                      ),
                    ).then((_) {
                      // Access thirdPageKey using the context
                      ThirdPage.thirdPageKey.currentState
                          ?.clearCompletedStepNumbers();
                    });
                  },
                  child: Hero(
                    tag: 'yourTag',
                    child: Image.asset(
                      'assets/Asset12@3x.png',
                      width: screenWidth * 0.28,
                      height: screenHeight * 0.20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
