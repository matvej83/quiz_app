import 'package:equatable/equatable.dart';

class TranslationEntity extends Equatable {
  const TranslationEntity({
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
