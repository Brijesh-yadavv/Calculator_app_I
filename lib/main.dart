import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'Button_setting.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
                'Calculator',
              ))),
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(flex: 1, child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),)),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),)),
              ],
            ),
          )
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                  child: GridView.builder(

                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                              userAnswer='';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColors: Colors.white,
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColors: Colors.white,
                        );
                      }
                      else if (index == buttons.length - 1) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color:isOperator(buttons[index]) ?Colors.deepPurple:Colors.white,

                          textColors: Colors.white,


                        )
                        ;
                      }
                      else if (index==buttons.length-2) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color:isOperator(buttons[index]) ?Colors.deepPurple:Colors.deepPurple.shade50,

                          textColors: Colors.deepPurple,


                        )
                        ;
                      }
                      else {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple.shade50,
                          textColors: isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                        );
                      }
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: buttons.length,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void equalPressed() {
    String finalQuestion=userQuestion;
    Parser p=Parser();
    Expression exp=p.parse(finalQuestion);
    ContextModel cm=ContextModel();
    double eval=exp.evaluate(EvaluationType.REAL,cm);


    userAnswer=eval.toString();
  }


  bool isOperator(String x) {
    if (x == '+' || x == '%' || x == '-' || x == '*' || x == '/' || x == "=")
      return true;
    return false;
  }
}