import 'package:echo/openAI_service.dart';
import 'package:echo/pallete.dart';
import 'package:echo/suggestion_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  final FlutterTts flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ECHO'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: generatedImageURL == null,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40)
                    .copyWith(top: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.borderColor),
                  borderRadius:
                      BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      generatedContent ??
                          'Hey Good Morning, what can I do for you?',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          fontSize: generatedContent == null ? 25 : 18,
                          color: Pallete.mainFontColor),
                    )),
              ),
            ),
            if (generatedImageURL != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageURL!)),
              ),
            Visibility(
              visible: generatedContent == null && generatedImageURL == null,
              child: const Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 10, 10),
                child: Text(
                  'Here are some suggestions',
                  style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Pallete.mainFontColor),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageURL == null,
              child: Column(
                children: const [
                  SuggestionBox(
                      boxColor: Pallete.firstSuggestionBoxColor,
                      description:
                          'A smarter way to stay organized and informed with ChatGPT',
                      headerText: 'chatGPT'),
                  SuggestionBox(
                      boxColor: Pallete.secondSuggestionBoxColor,
                      description:
                          'Get inspired and stay creative with your personal assistant powered by Dall-E',
                      headerText: 'Dall-E'),
                  SuggestionBox(
                      boxColor: Pallete.thirdSuggestionBoxColor,
                      description:
                          'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                      headerText: 'Smart Voice Assistant'),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await _speechToText.hasPermission &&
              _speechToText.isNotListening) {
            await _startListening();
          } else if (_speechToText.isListening) {
            final speech = await openAIService.isArtPromptAPI(_lastWords);

            if (speech.contains('https')) {
              generatedImageURL = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageURL = null;
              generatedContent = speech;

              setState(() {});
              await systemSpeak(speech);
            }
            await _stopListening();
          } else {
            _initSpeech();
          }
        },
        child: Icon(_speechToText.isListening ? Icons.stop : Icons.mic),
      ),
    );
  }
}
