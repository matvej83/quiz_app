import 'package:equatable/equatable.dart';

class MistakeEntity extends Equatable {
  const MistakeEntity({
    required this.word,
    required this.suggestion,
    required this.reason,
  });

  final String word;
  final String suggestion;
  final String reason;

  @override
  List<Object?> get props => [word, suggestion, reason];
}
