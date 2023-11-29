import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:foodgame/pages/second_page.dart';

class Fourthpage extends StatefulWidget {
  static String fourth_page = 'game/fourth_page';

  const Fourthpage({Key? key}) : super(key: key);

  @override
  State<Fourthpage> createState() => _FourthpageState();
}


AudioPlayer player = AudioPlayer();
void _playSound(String soundPath) async {
  // await player.setVolume(10);
  await player.play(AssetSource(soundPath));
}

class _FourthpageState extends State<Fourthpage> with TickerProviderStateMixin {
  late double height;
  late double width;

  void _playButtonSound() {
    // Implement your button sound logic here
  }

  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

   _playSound('hai.mp3');
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }
// assets/lastsoundpage.mp3
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    child: Image.asset(
                      'assets/final.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedBuilder(
                        animation: _blinkController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _blinkController.value,
                            child: ElevatedButton(
                              
                              onPressed: () {
                                _playSound('buttonclickevent.mp3');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondPage()),
                                );
                              },
                              child:const Text('Go Back to Makeover'),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
