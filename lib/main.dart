import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizAppState createState() => _QuizAppState();
// ignore: prefer_typing_uninitialized_variables
}

class _QuizAppState extends State<QuizApp> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['A) Paris', 'B) London', 'C) Rome', 'D) Berlin'],
      'answer': 'A'
    },
    {
      'question': 'What is the chemical symbol for gold?',
      'options': ['A)Au', 'B)Ag', 'C)Fe', 'D)Hg'],
      'answer': 'A'
    },      
    {
      'question': 'what is the largest planet in our solar system?',
      'options': ['A)Earth','B)Jupiter','c)Mars','D)Saturn'],
      'answer': 'B'
    },
    {
      'question': 'what is the smallest country in the world?',
      'options': ['A)Vatican City', 'B)Monaco', 'C)Nauru', 'D)Tuvalu'],
      'answer': 'A'
    },
    {
      'question': 'What is the boiling point of water?',
      'options': ['A)100°C', 'B)90°C', 'C)80°C', 'D)110°C'],
      'answer': 'A'
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'options': ['A)Harper Lee', 'B)Mark Twain', 'C)Ernest Hemingway', 'D)F. Scott Fitzgerald'],
      'answer': 'A'
    }
  ];

  int currentQuestion = 0;
  int score = 0;
  String? selectedOption;
  bool showResult = false;
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    fadeInQuestion();
  }

  void fadeInQuestion() {
    setState(() {
      opacityLevel = 0.0;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  void checkAnswer(String selected) {
    if (selected == questions[currentQuestion]['answer']) {
      score++;
    }
    setState(() {
      showResult = true;
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestion++;
      selectedOption = null;
      showResult = false;
    });
    fadeInQuestion();
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion >= questions.length) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blueGrey.shade100,
          body: Center(
            child: Text(
              '🎉 Quiz Finished!\nYour score: $score/${questions.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final question = questions[currentQuestion];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Quiz App')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedOpacity(
            opacity: opacityLevel,
            duration: Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q${currentQuestion + 1}: ${question['question']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                ...question['options'].map<Widget>((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option[0],
                    groupValue: selectedOption,
                    onChanged: showResult
                        ? null
                        : (value) => setState(() {
                            selectedOption = value;
                          }),
                  );
                }).toList(),
                SizedBox(height: 10),
                if (!showResult)
                  ElevatedButton(
                    onPressed: selectedOption == null
                        ? null
                        : () => checkAnswer(selectedOption!),
                    child: Text('Submit'),
                  ),
                if (showResult)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedOption == question['answer']
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          selectedOption == question['answer']
                              ? '✅ Correct!'
                              : '❌ Wrong! Correct answer is ${question['answer']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedOption == question['answer']
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: nextQuestion,
                          child: Text('Next'),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}