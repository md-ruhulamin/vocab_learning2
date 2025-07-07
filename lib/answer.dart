import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/widget/custom_text.dart';
import 'package:vocab_learning/quiz/quiz_model.dart';

class AnswerSheetScreen extends StatefulWidget {
  AnswerSheetScreen({super.key, required this.quizList, required this.userAnswers});

  Set<QuizQuestion> quizList;
    final Map<int, String> userAnswers;
  @override
  State<AnswerSheetScreen> createState() => _AnswerSheetScreenState();
}

class _AnswerSheetScreenState extends State<AnswerSheetScreen> {

  @override
  void initState() {
    super.initState();
  
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Answer Sheet"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height-60,
                child: ListView.builder(
                    itemCount: widget.quizList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text:
                                  "Q${index + 1} ${widget.quizList.elementAt(index).question}",
                              fontSize: 22,
                            ),
                            OptionWidget(
                                optionChar: "A",
                                optionText:
                                    "${widget.quizList.elementAt(index).options[0]}",
                                correctAnswer:
                                    "${widget.quizList.elementAt(index).correctAnswer}",
                                myanswer:widget.userAnswers[index]),
                            OptionWidget(
                                optionChar: "B",
                                optionText:
                                    "${widget.quizList.elementAt(index).options[1]}",
                                correctAnswer:
                                    "${widget.quizList.elementAt(index).correctAnswer}",
                                 myanswer:widget.userAnswers[index]),
                            OptionWidget(
                                optionChar: "C",
                                optionText:
                                    "${widget.quizList.elementAt(index).options[2]}",
                                correctAnswer:
                                    "${widget.quizList.elementAt(index).correctAnswer}",
                                 myanswer:widget.userAnswers[index]),
                            OptionWidget(
                                optionChar: "D",
                                optionText:
                                    "${widget.quizList.elementAt(index).options[3]}",
                                correctAnswer:
                                    "${widget.quizList.elementAt(index).correctAnswer}",
                                 myanswer:widget.userAnswers[index]),
                          ],
                        ),
                      ));
                    }))));
  }
}

class OptionWidget extends StatelessWidget {
  final correctAnswer;
  final myanswer;
  final optionText;
  final String optionChar;
  const OptionWidget({
    super.key,
    this.optionText,
    required this.optionChar,
    this.correctAnswer,
    this.myanswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: correctAnswer == optionText ?  Colors.green : myanswer==optionText? Colors.red.shade400: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(
          backgroundColor:correctAnswer == optionText ?  Colors.white: myanswer==optionText? Colors.white: Colors.grey,     
               radius: 15,
          child: CustomText(
            text: optionChar,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
        title: CustomText(
          text: optionText,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

