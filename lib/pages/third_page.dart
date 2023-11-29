import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:foodgame/pages/fourth_page.dart';

class ThirdPage extends StatefulWidget {
  static String thirdpage = 'game/thirdpage';
  final VoidCallback onPageRefresh;
  static final GlobalKey<_ThirdPageState> thirdPageKey =
      GlobalKey<_ThirdPageState>();
  const ThirdPage({Key? key, required this.onPageRefresh}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();

  void resetState() {}
}

final List<String> stepImages = [
  'assets/self_item_1.png',
  'assets/self_item_2.png',
  'assets/self_item_3.png',
  'assets/self_item_4.png',
  'assets/self_item_5.png',
];

Set<int> completedStepNumbers = {};

int currentStep = 0;
String? draggedImagePath;

AudioPlayer player = AudioPlayer();
void _playSound(String soundPath) async {

  await player.play(AssetSource(soundPath));
}



void _playbgsound(String soundPath) async {

  
   await player.play(AssetSource(soundPath));
  // player.setReleaseMode(ReleaseMode.LOOP);

}




class _ThirdPageState extends State<ThirdPage> with TickerProviderStateMixin {
  double height = 0.0;
  double width = 0.0;

  late List<AnimationController> _animationControllers;
  bool isDrawerOpen = false;

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  void showAnimatedCompletionDialog(String completionMessage) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(

            child: ScaleTransition(
              scale: animation1.drive(
                Tween(begin: 0.5, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  // color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Step Completed!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(completionMessage),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

   
    Future.delayed(const Duration(seconds: 2), () {
      clearCompletedStepNumbers();
      Navigator.of(context).pop();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    completedStepNumbers.clear();
  }

  void clearCompletedStepNumbers() {
    completedStepNumbers.clear();
  }

  @override
  void initState() {
    super.initState();
// _playbgsound('bgaudio.mp3');
    completedStepNumbers.clear();
    
    _animationControllers = List.generate(
      stepImages.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    currentStep = 0;
    draggedImagePath = null;
    stepImages.shuffle();
    widget.onPageRefresh();
  }

  void resetState() {
    setState(() {
      currentStep = 0;
      draggedImagePath = null;
      completedStepNumbers.clear();
    });
  }

  void rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    List<Positioned> positionedWidgets = [];

    for (int i = 0; i < stepImages.length; i++) {
      positionedWidgets.add(
        Positioned(
          top: height * 0.18,
          left: width * (i * 0.17 + 0.10),
          child: Draggable(
            data: stepImages[i],
            feedback: AnimatedBuilder(
              animation: _animationControllers[i],
              builder: (context, child) {
                return Transform.scale(
                  scale: _animationControllers[i].value,
                  child: Container(
                    width: width * 0.20,
                    height: height * 0.20,
                    decoration: const BoxDecoration(
                        // Add decoration if needed
                        // color: i == currentStep ? Colors.red : Colors.blue,
                        ),
                    child: Image.asset(
                      stepImages[i],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            onDragStarted: () {
              _animationControllers[i].forward();
            },
            onDragCompleted: () {
              if (canDropImage(stepImages[i])) {
                showAnimatedCompletionDialog('Step ${i + 1} completed!');
                setState(() {
                  draggedImagePath = stepImages[i];
                });
              }
            },
            // childWhenDragging: Container(),
            child: MouseRegion(
              cursor: SystemMouseCursors.grabbing,
              child: Container(
                width: width * 0.06,
                height: height * 0.15,
                decoration: const BoxDecoration(

                    // color: i == currentStep ? Colors.red : Colors.blue,
                    ),
                child: Image.asset(
                  stepImages[i],
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      );
    }

    positionedWidgets.add(
      Positioned(
        left: width * 0.26,
        bottom: height * 0.15,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return ClipPath(
              child: Container(
                width: width * 0.20,
                height: height * 0.15,
                child: draggedImagePath != null
                    ? Image.asset(
                        draggedImagePath!,
                        fit: BoxFit.fill,
                      )
                    : const SizedBox.shrink(),
              ),
            );
          },
          onAccept: (data) {
            print('Current Step: $currentStep, Image Path: $data');
            if (canDropImage(data as String)) {
              setState(() {
                draggedImagePath = data;
                currentStep++;

                if (currentStep == 0) {
                  draggedImagePath = 'assets/Asset7@3x.png';
                } else if (currentStep == 1) {
                  draggedImagePath = 'assets/step2.png';
                } else if (currentStep == 2) {
                  draggedImagePath = 'assets/step3_1.png';
                } else if (currentStep == 3) {
                  draggedImagePath = 'assets/Asset22@3x.png';
                } else if (currentStep == 4) {
                  draggedImagePath = 'assets/step5_1.png';
                } else if (currentStep == 5) {
                  draggedImagePath = 'assets/step6.png';
                }

                for (int step = 1; step <= currentStep; step++) {
                  completedStepNumbers.clear();
                  // Check if the step is already completed
                  if (!completedStepNumbers.contains(currentStep)) {
                    final duration = Duration(seconds: 0);
                    Future.delayed(duration, () {
                      showAnimatedCompletionDialog(
                          'Step $currentStep completed!');
                      completedStepNumbers.add(currentStep);
                    });
                  }
                }

                if (currentStep == stepImages.length) {
                  _playSound('Childyeahsound.mp3');
                  final duration = Duration(seconds: 1 * (currentStep + 1));

                  print("vvfvfdvfvfvfvfvfvfvfvf$completedStepNumbers");
                  completedStepNumbers.clear();
                  Future.delayed(duration, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Fourthpage()),
                    );
                  }
                  );
                } else {
                  _playSound('Childyeahsound.mp3');
                }
              });
            } else {
              _playSound('wrong.mp3');
            }
          },
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/photo_2023-11-25_09-18-55.jpg',
              fit: BoxFit.fill,
              height: height,
              width: width,
            ),
            ...positionedWidgets,
          ],
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: toggleDrawer,
          ),
          title: Text('Hint'),
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Hints'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Hint 1'),
                onTap: () {
                  // Handle hint 1
                },
              ),
              ListTile(
                title: Text('Hint 2'),
                onTap: () {
                  // Handle hint 2
                },
              ),
            ]
            ),
            ),
            ),
    );
  }

  bool canDropImage(String imagePath) {
    String lowerCasePath = imagePath.toLowerCase();
    if (currentStep == 0 && lowerCasePath == 'assets/self_item_1.png') {
      return true;
    } else if (currentStep == 1 && lowerCasePath == 'assets/self_item_2.png') {
      return true;
    } else if (currentStep == 2 && lowerCasePath == 'assets/self_item_3.png') {
      return true;
    } else if (currentStep == 3 && lowerCasePath == 'assets/self_item_4.png') {
      return true;
    } else if (currentStep == 4 && lowerCasePath == 'assets/self_item_5.png') {
      return true;
    }

    return false;
  }
}
