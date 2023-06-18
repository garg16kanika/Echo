import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SuggestionBox extends StatelessWidget {
  final Color boxColor;
  final String headerText;
  final String description;
  const SuggestionBox(
      {super.key,
      required this.boxColor,
      required this.description,
      required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: boxColor),
      child: Column(
        children: [Text(headerText), Text(description)],
      ),
    );
  }
}
