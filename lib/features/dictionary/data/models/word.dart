import 'package:equatable/equatable.dart';

class Word extends Equatable {
  const Word({
    required this.englishWord,
    required this.russianWord,
    this.count,
    this.probability,
  });

  final String englishWord;
  final String russianWord;
  final int? count;
  final double? probability;

  @override
  List<dynamic> get props => [englishWord, russianWord, count, probability];
}
