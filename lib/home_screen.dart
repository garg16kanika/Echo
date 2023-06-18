import 'package:echo/pallete.dart';
import 'package:echo/suggestion_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECHO'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Pallete.assistantCircleColor,
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                Image.asset('assets/images/virtualAssistant.png'),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius:
                    BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              child: Text('Hey Good Morning what can I do for you?'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text('Here are some suggestions'),
            ),
            SuggestionBox(
                boxColor: Pallete.firstSuggestionBoxColor,
                description: '',
                headerText: ''),
            SuggestionBox(
                boxColor: Pallete.secondSuggestionBoxColor,
                description: '',
                headerText: ''),
            SuggestionBox(
                boxColor: Pallete.thirdSuggestionBoxColor,
                description: '',
                headerText: ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.mic),
      ),
    );
  }
}
