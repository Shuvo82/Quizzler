
import 'package:flutter/material.dart';
import 'package:quizzler/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain=QuizBrain();

void main() => runApp(quizzler());

class quizzler extends StatelessWidget {
  const quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff181161),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: quizpage(),
          ) ,
        ),
      ),
    );
  }
}

class quizpage extends StatefulWidget {
  const quizpage({Key? key}) : super(key: key);

  @override
  State<quizpage> createState() => _quizpageState();
}

class _quizpageState extends State<quizpage> {
  int score=0;
  //Question q1=Question('q', false);
  //Question q=Question('You can lead a cow down stairs but not up stairs.', false);


  /*List <String> ques=[
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];*/
  /*List <String> ans=[
    'false', 'true','true'
  ];*/



  void checkAnswer(bool userAns) {
    bool correctAns = quizBrain.getCorrectAns();

    setState(() {
      if(quizBrain.isFinished()){
        int totalScore=quizBrain.ques_list.length;

        Alert(
            context: context,
            title: "Finished!",
            desc: "Your result is: $totalScore/$score").show();
        quizBrain.reset();
      }


    });


    if (userAns == correctAns) {
      score++;
      quizBrain.scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    }
    else {
      quizBrain.scoreKeeper.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
    quizBrain.nextQues();


  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[
         Expanded(
          flex: 12,
            child: Center(
              child: Text(quizBrain.quesText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
              ),
            ),

        ),
        Expanded(
          flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
              child: ElevatedButton(
                  onPressed: (){
                    checkAnswer(false);

                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xfffa1919)
                  ),
                  child: const Text('False',
                    style: TextStyle(
                      fontSize: 29,
                    ),
                  )
              ),
            )
        ),
        Expanded(
          flex:2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (){

                    checkAnswer(true);

                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff1cb300)
                  ),
                  child: const Text('True',
                    style: TextStyle(
                      fontSize: 29,
                    ),
                  )),
            )
        ),
        Expanded(
          child: Row(
            children: quizBrain.scoreKeeper,
              

          ),
        )
        
      ],
    );
  }
}


