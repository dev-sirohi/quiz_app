import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html_character_entities/html_character_entities.dart';

void main() {
  runApp(const MaterialApp(
    home: QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  Map? mapResponse;
  String question = "";
  String correctAnswer = "";
  List? results;
  List? mcq;
  int count = 0;
  String changeColor1 = "null";
  String changeColor2 = "null";
  String changeColor3 = "null";
  String changeColor4 = "null";
  bool isPressed = false;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=10&difficulty=easy&type=multiple'));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
      });
    }

    results = mapResponse!['results'];
    setter(results);
  }

  void setter(List? results) {
    if (count < 5) {
      question = HtmlCharacterEntities.decode(results?[count]['question']);
      mcq = results?[count]['incorrect_answers'];

      correctAnswer =
          HtmlCharacterEntities.decode(results?[count]['correct_answer']);

      print(correctAnswer);
      mcq?.add(correctAnswer);
      mcq?.shuffle();
    } else {
      print("Test Finished!");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EndTest()));
    }
  }

  void nextQuestion() {
    count++;
    setter(results);
    build(context);
    isPressed = false;
    changeColor1 = "null";
    changeColor2 = "null";
    changeColor3 = "null";
    changeColor4 = "null";
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void myCallback() {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        toolbarHeight: 100.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(1.50),
            color: Colors.amber,
            margin: const EdgeInsets.fromLTRB(150.0, 20.0, 150.0, 1.0),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 1.0, 40.0, 1.0),
            padding: const EdgeInsets.all(30.0),
            child: question == 'null'
                ? Container()
                : Text(
                    question.toString(),
                    style: const TextStyle(fontSize: 20.0),
                  ),
          ),
          Container(
            child: TextButton(
              onPressed: (() => {
                    setState(() {
                      if (!isPressed) {
                        if (mcq?[0] == correctAnswer) {
                          changeColor1 = "true";
                        } else {
                          changeColor1 = "false";
                        }
                      }

                      myCallback();
                    })
                  }),
              child: Text(
                mcq?[0] ?? "Options 1",
                style: TextStyle(
                    color: changeColor1 == "true"
                        ? Colors.green
                        : changeColor1 == "false"
                            ? Colors.red
                            : Colors.grey),
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: (() => {
                    setState(() {
                      if (!isPressed) {
                        if (mcq?[1] == correctAnswer) {
                          changeColor2 = "true";
                        } else {
                          changeColor2 = "false";
                        }
                      }

                      myCallback();
                    })
                  }),
              child: Text(
                mcq?[1] ?? "Options 2",
                style: TextStyle(
                    color: changeColor2 == "true"
                        ? Colors.green
                        : changeColor2 == "false"
                            ? Colors.red
                            : Colors.grey),
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: (() => {
                    setState(() {
                      if (!isPressed) {
                        if (mcq?[2] == correctAnswer) {
                          changeColor3 = "true";
                        } else {
                          changeColor3 = "false";
                        }
                      }

                      myCallback();
                    })
                  }),
              child: Text(
                mcq?[2] ?? "Options 3",
                style: TextStyle(
                    color: changeColor3 == "true"
                        ? Colors.green
                        : changeColor3 == "false"
                            ? Colors.red
                            : Colors.grey),
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: (() => {
                    setState(() {
                      if (!isPressed) {
                        if (mcq?[3] == correctAnswer) {
                          changeColor4 = "true";
                        } else {
                          changeColor4 = "false";
                        }
                      }
                      myCallback();
                    })
                  }),
              child: Text(
                mcq?[3] ?? "Options 4",
                style: TextStyle(
                    color: changeColor4 == "true"
                        ? Colors.green
                        : changeColor4 == "false"
                            ? Colors.red
                            : Colors.grey),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
              ),
              onPressed: (() => setState(() {
                    nextQuestion();
                  })),
              child: const Text(
                "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EndTest extends StatefulWidget {
  const EndTest({super.key});

  @override
  State<EndTest> createState() => _EndTestState();
}

class _EndTestState extends State<EndTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        toolbarHeight: 100.0,
      ),
      body: Center(
        child: Text("TEST FINISHED!"),
      ),
    );
  }
}
