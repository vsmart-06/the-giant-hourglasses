import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:speech_to_text/speech_recognition_result.dart";
import "package:speech_to_text/speech_to_text.dart";
import "package:harry_potter_points/widgets/house_card.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;
  SpeechToText stt = SpeechToText();
  late bool speechAvailable;
  bool entry = true;
  String command = "";
  bool recording = false;

  @override
  void initState() {
    super.initState();

    initializeSpeech();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    opacity = Tween<double>(begin: 1, end: 0).animate(animationController);
    opacity.addStatusListener(checkFinish);
    animationController.forward();
  }

  void initializeSpeech() async {
    speechAvailable = await stt.initialize();
    setState(() {});
  }

  void startListening() async {
    await stt.listen(onResult: registerWords);
    setState(() {});
  }

  void stopListening() async {
    await stt.stop();
    setState(() {});
  }

  void registerWords(SpeechRecognitionResult words) {
    setState(() {
      command = words.recognizedWords;
    });
    print(command);
  }

  void checkFinish(AnimationStatus status) {
    if (status.isCompleted) {
      setState(() {
        entry = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "The Giant Hourglasses",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.jost().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Color(0xFF2D004D),
          body: Stack(
            children: [
              Center(
                child: Image(
                  image: NetworkImage("https://i.imgur.com/DOYiIXU.jpeg"),
                  opacity: AlwaysStoppedAnimation(0.3),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HouseCard(
                          house: "Gryffindor",
                          points: 0,
                          colour: Color(0xFF740001),
                          accent: Color(0xFFD3A625),
                          crest: "https://i.imgur.com/e5yoXUs.png"),
                      HouseCard(
                          house: "Hufflepuff",
                          points: 0,
                          colour: Color(0xFFFFD800),
                          accent: Colors.black,
                          crest: "https://i.imgur.com/6va7uxA.png"),
                      HouseCard(
                          house: "Ravenclaw",
                          points: 0,
                          colour: Color(0xFF0E1A40),
                          accent: Color(0xFF946B2D),
                          crest: "https://i.imgur.com/9RKkW4j.png"),
                      HouseCard(
                          house: "Slytherin",
                          points: 0,
                          colour: Color(0xFF1A472A),
                          accent: Color(0xFF5D5D5D),
                          crest: "https://i.imgur.com/KPORQ6B.png"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Change points for a house",
            onPressed: () async {
              recording = !recording;
              recording ? startListening() : stopListening();
            },
            backgroundColor: Color(0xFF5758FF),
            child: !recording ? Icon(Icons.mic) : Icon(Icons.stop),
          ),
        ),
        entry
            ? Scaffold(
                backgroundColor: Colors.transparent,
                body: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  duration: Duration(milliseconds: 500),
                  color: Color(0xFF2D004D),
                  child: Image(
                    image: NetworkImage("https://i.imgur.com/fz5Q9ap.png"),
                    opacity: opacity,
                  ),
                ))
            : Container(),
      ],
    );
  }
}
