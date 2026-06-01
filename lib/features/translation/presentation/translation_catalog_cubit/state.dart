import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/translation/domain/entity/translation_entity.dart';

class TranslationCatalogState extends Equatable {
  const TranslationCatalogState({
    this.isLoading = false,
    this.translations = const [],
  });

  final bool isLoading;
  final List<TranslationEntity> translations;

  TranslationCatalogState copyWith({
    bool? isLoading,
    List<TranslationEntity>? translations,
  }) {
    return TranslationCatalogState(
      isLoading: isLoading ?? this.isLoading,
      translations: translations ?? this.translations,
    );
  }

  @override
  List<dynamic> get props => [isLoading, translations];
}
