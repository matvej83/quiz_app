import 'package:flutter/material.dart';

import '../../database/app_database.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.database});

  final AppDatabase database;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Word> words = [];

  int currentIndex = 0;

  final controller = TextEditingController();

  bool answered = false;

  bool correct = false;

  @override
  void initState() {
    super.initState();

    loadWords();
  }

  Future<void> loadWords() async {
    final result = await widget.database.getQuizWords(10);

    setState(() {
      words = result;
    });
  }

  void checkAnswer() {
    final current = words[currentIndex];

    final answer = controller.text.trim().toLowerCase();

    setState(() {
      answered = true;

      correct = answer == current.russianWord.toLowerCase();
    });
  }

  void nextQuestion() {
    controller.clear();

    setState(() {
      answered = false;

      currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (words.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (currentIndex >= words.length) {
      return const Scaffold(body: Center(child: Text('Quiz completed')));
    }

    final current = words[currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('English Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Text(
              current.englishWord,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Введите перевод',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: checkAnswer,
              child: const Text('Проверить'),
            ),

            const SizedBox(height: 24),

            if (answered)
              Column(
                children: [
                  Text(correct ? 'Правильно' : 'Неправильно'),

                  const SizedBox(height: 8),

                  Text('Ответ: ${current.russianWord}'),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: nextQuestion,
                    child: const Text('Далее'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
