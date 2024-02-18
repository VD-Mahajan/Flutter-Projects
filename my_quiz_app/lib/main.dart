import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class SingleQuestionModel {
  final String? question;
  final List<String>? options;
  final int? answerIndex;

  const SingleQuestionModel({this.question, this.options, this.answerIndex});
}

class _QuizAppState extends State {
  List allQuestions = [
    const SingleQuestionModel(
      question:
          'Which company was formed by the British in India in the year 1600?',
      options: [
        'India East Company',
        'East India Company',
        'West India Company',
        'British Company   '
      ],
      answerIndex: 1,
    ),
    const SingleQuestionModel(
      question: 'Who was the first Speaker of Lok Sabha?',
      options: [
        'Sardar Patel',
        'Ganesh Mavalankar',
        'H. J. Virgo',
        'None of these'
      ],
      answerIndex: 1,
    ),
    const SingleQuestionModel(
      question: 'When was the constitution of Jammu and Kashmir implemented?',
      options: [
        '26 January 1957',
        '26 January 1950',
        '01 August 1950',
        'None of these'
      ],
      answerIndex: 0,
    ),
    const SingleQuestionModel(
      question: 'Where did the formation of Azad Hind Fauj take Place?',
      options: ['Thailand', 'Singapore', 'Russia', 'Germany'],
      answerIndex: 1,
    ),
    const SingleQuestionModel(
      question:
          "Who played a significant role in India's struggle for independence and is known as the ' Father of the Nation'?",
      options: [
        'Jawaharlal Nehru',
        'Bhagat Singh',
        'Mahatma Gandhi',
        'Subhas Chandra Bose'
      ],
      answerIndex: 2,
    ),
  ];

  bool isQustion = true;
  bool isNotStarted = true;
  bool clicked = false;
  int questinIndex = 0;
  int correctAnswer = 0;
  int selected = -1;

  Color checkColor(int option) {
    if (selected != -1) {
      if (option == allQuestions[questinIndex].answerIndex) {
        return Colors.green;
      } else if (option == selected) {
        return Colors.red;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  Scaffold isQuestionScreen() {
    if (isNotStarted) {
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/quiz.png',
                  height: 350,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isNotStarted = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text('developed by vishal'),
              ],
            ),
          ],
        ),
      );
    }
    if (isQustion) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'My QuizApp',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Question: ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Text(
                  '${questinIndex + 1}/${allQuestions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Q. ${allQuestions[questinIndex].question}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selected = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 65),
                backgroundColor: checkColor(0),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'A.   ${allQuestions[questinIndex].options[0]}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selected = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 65),
                backgroundColor: checkColor(1),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    // textAlign: TextAlign.left,
                    'B.   ${allQuestions[questinIndex].options[1]}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selected = 2;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 65),
                backgroundColor: checkColor(2),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'C.   ${allQuestions[questinIndex].options[2]}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selected = 3;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 65),
                backgroundColor: checkColor(3),
                elevation: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'D.   ${allQuestions[questinIndex].options[3]}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            (selected == -1 && clicked == true)
                ? const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: Text(
                        'select at least one option',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 5,
          onPressed: () {
            setState(() {
              clicked = true;
              if (questinIndex == allQuestions.length - 1 && selected != -1) {
                isQustion = !isQustion;
              }
              if (selected == allQuestions[questinIndex].answerIndex) {
                correctAnswer++;
              }
              if (selected != -1) {
                questinIndex++;
                clicked = false;
                selected = -1;
              }
            });
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 244, 244),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Congratulations',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/congrats.jpg',
                height: 400,
              ),
              const SizedBox(
                  // height: 20,
                  ),
              const Text(
                'Congratulations !!!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'You have completed the quiz ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your score : $correctAnswer/${allQuestions.length} ',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isQustion = true;
                    questinIndex = 0;
                    correctAnswer = 0;
                    selected = -1;
                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 60),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isQuestionScreen(),
      // home: HomeScreen(),
    );
  }
}
