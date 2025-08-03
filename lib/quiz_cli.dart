import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['A) Paris', 'B) London', 'C) Rome', 'D) Berlin'],
      'answer': 'A'
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['A) Earth', 'B) Mars', 'C) Jupiter', 'D) Venus'],
      'answer': 'B'
    },
    // Add the rest of your questions...
  ];

  int currentQuestion = 0;
  int score = 0;
  String? selectedOption;
  bool showResult = false;

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
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion >= questions.length) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Quiz Finished! Your score: $score/${questions.length}',
              style: TextStyle(fontSize: 24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Q${currentQuestion + 1}: ${question['question']}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              ...question['options'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option[0], // A, B, C, or D
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
                Column(
                  children: [
                    Text(
                      selectedOption == question['answer']
                          ? 'Correct!'
                          : 'Wrong! Correct answer is ${question['answer']}',
                      style: TextStyle(
                          fontSize: 16,
                          color: selectedOption == question['answer']
                              ? Colors.green
                              : Colors.red),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: nextQuestion,
                      child: Text('Next'),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}