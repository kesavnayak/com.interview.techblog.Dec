import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:techblog/Helper/accordion.dart';
import 'package:techblog/Models/question_model.dart';

class CardAccordion extends StatefulWidget {
  final _screenshortController = ScreenshotController();
  final List<QuestionModel> snapshot;
  final int index;

  CardAccordion(this.snapshot, this.index, {Key? key}) : super(key: key);

  @override
  _CardAccordionState createState() => _CardAccordionState();
}

class _CardAccordionState extends State<CardAccordion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Screenshot(
          controller: widget._screenshortController,
          child: Accordion(
              widget.snapshot, widget.index, widget._screenshortController),
        ),
      ],
    );
  }
}
