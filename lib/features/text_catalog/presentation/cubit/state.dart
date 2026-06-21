import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/text_catalog/domain/entity/text_entity.dart';

class TextCatalogState extends Equatable {
  const TextCatalogState({
    this.isLoading = false,
    this.translations = const [],
  });

  final bool isLoading;
  final List<TextEntity> translations;

  TextCatalogState copyWith({bool? isLoading, List<TextEntity>? translations}) {
    return TextCatalogState(
      isLoading: isLoading ?? this.isLoading,
      translations: translations ?? this.translations,
    );
  }

  @override
  List<dynamic> get props => [isLoading, translations];
}
