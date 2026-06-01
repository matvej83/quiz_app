import 'package:equatable/equatable.dart';

class TextEntity extends Equatable {
  const TextEntity({
    required this.id,
    required this.title,
    required this.text,
    required this.level,
  });

  final int id;
  final String title;
  final List<String> text;
  final int level;

  @override
  List<Object?> get props => [id, title, text, level];
}
