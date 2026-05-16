// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _englishWordMeta = const VerificationMeta(
    'englishWord',
  );
  @override
  late final GeneratedColumn<String> englishWord = GeneratedColumn<String>(
    'english_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _russianWordMeta = const VerificationMeta(
    'russianWord',
  );
  @override
  late final GeneratedColumn<String> russianWord = GeneratedColumn<String>(
    'russian_word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _probabilityMeta = const VerificationMeta(
    'probability',
  );
  @override
  late final GeneratedColumn<double> probability = GeneratedColumn<double>(
    'probability',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    englishWord,
    russianWord,
    count,
    probability,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<Word> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('english_word')) {
      context.handle(
        _englishWordMeta,
        englishWord.isAcceptableOrUnknown(
          data['english_word']!,
          _englishWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_englishWordMeta);
    }
    if (data.containsKey('russian_word')) {
      context.handle(
        _russianWordMeta,
        russianWord.isAcceptableOrUnknown(
          data['russian_word']!,
          _russianWordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_russianWordMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('probability')) {
      context.handle(
        _probabilityMeta,
        probability.isAcceptableOrUnknown(
          data['probability']!,
          _probabilityMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {englishWord, russianWord};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      englishWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english_word'],
      )!,
      russianWord: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}russian_word'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      ),
      probability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}probability'],
      ),
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class Word extends DataClass implements Insertable<Word> {
  final String englishWord;
  final String russianWord;
  final int? count;
  final double? probability;
  const Word({
    required this.englishWord,
    required this.russianWord,
    this.count,
    this.probability,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['english_word'] = Variable<String>(englishWord);
    map['russian_word'] = Variable<String>(russianWord);
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || probability != null) {
      map['probability'] = Variable<double>(probability);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      englishWord: Value(englishWord),
      russianWord: Value(russianWord),
      count: count == null && nullToAbsent
          ? const Value.absent()
          : Value(count),
      probability: probability == null && nullToAbsent
          ? const Value.absent()
          : Value(probability),
    );
  }

  factory Word.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      englishWord: serializer.fromJson<String>(json['englishWord']),
      russianWord: serializer.fromJson<String>(json['russianWord']),
      count: serializer.fromJson<int?>(json['count']),
      probability: serializer.fromJson<double?>(json['probability']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'englishWord': serializer.toJson<String>(englishWord),
      'russianWord': serializer.toJson<String>(russianWord),
      'count': serializer.toJson<int?>(count),
      'probability': serializer.toJson<double?>(probability),
    };
  }

  Word copyWith({
    String? englishWord,
    String? russianWord,
    Value<int?> count = const Value.absent(),
    Value<double?> probability = const Value.absent(),
  }) => Word(
    englishWord: englishWord ?? this.englishWord,
    russianWord: russianWord ?? this.russianWord,
    count: count.present ? count.value : this.count,
    probability: probability.present ? probability.value : this.probability,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      englishWord: data.englishWord.present
          ? data.englishWord.value
          : this.englishWord,
      russianWord: data.russianWord.present
          ? data.russianWord.value
          : this.russianWord,
      count: data.count.present ? data.count.value : this.count,
      probability: data.probability.present
          ? data.probability.value
          : this.probability,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('englishWord: $englishWord, ')
          ..write('russianWord: $russianWord, ')
          ..write('count: $count, ')
          ..write('probability: $probability')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(englishWord, russianWord, count, probability);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.englishWord == this.englishWord &&
          other.russianWord == this.russianWord &&
          other.count == this.count &&
          other.probability == this.probability);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> englishWord;
  final Value<String> russianWord;
  final Value<int?> count;
  final Value<double?> probability;
  final Value<int> rowid;
  const WordsCompanion({
    this.englishWord = const Value.absent(),
    this.russianWord = const Value.absent(),
    this.count = const Value.absent(),
    this.probability = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordsCompanion.insert({
    required String englishWord,
    required String russianWord,
    this.count = const Value.absent(),
    this.probability = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : englishWord = Value(englishWord),
       russianWord = Value(russianWord);
  static Insertable<Word> custom({
    Expression<String>? englishWord,
    Expression<String>? russianWord,
    Expression<int>? count,
    Expression<double>? probability,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (englishWord != null) 'english_word': englishWord,
      if (russianWord != null) 'russian_word': russianWord,
      if (count != null) 'count': count,
      if (probability != null) 'probability': probability,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordsCompanion copyWith({
    Value<String>? englishWord,
    Value<String>? russianWord,
    Value<int?>? count,
    Value<double?>? probability,
    Value<int>? rowid,
  }) {
    return WordsCompanion(
      englishWord: englishWord ?? this.englishWord,
      russianWord: russianWord ?? this.russianWord,
      count: count ?? this.count,
      probability: probability ?? this.probability,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (englishWord.present) {
      map['english_word'] = Variable<String>(englishWord.value);
    }
    if (russianWord.present) {
      map['russian_word'] = Variable<String>(russianWord.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (probability.present) {
      map['probability'] = Variable<double>(probability.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('englishWord: $englishWord, ')
          ..write('russianWord: $russianWord, ')
          ..write('count: $count, ')
          ..write('probability: $probability, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      required String englishWord,
      required String russianWord,
      Value<int?> count,
      Value<double?> probability,
      Value<int> rowid,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<String> englishWord,
      Value<String> russianWord,
      Value<int?> count,
      Value<double?> probability,
      Value<int> rowid,
    });

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get englishWord => $composableBuilder(
    column: $table.englishWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get russianWord => $composableBuilder(
    column: $table.russianWord,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get englishWord => $composableBuilder(
    column: $table.englishWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get russianWord => $composableBuilder(
    column: $table.russianWord,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get englishWord => $composableBuilder(
    column: $table.englishWord,
    builder: (column) => column,
  );

  GeneratedColumn<String> get russianWord => $composableBuilder(
    column: $table.russianWord,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => column,
  );
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          Word,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (Word, BaseReferences<_$AppDatabase, $WordsTable, Word>),
          Word,
          PrefetchHooks Function()
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> englishWord = const Value.absent(),
                Value<String> russianWord = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<double?> probability = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion(
                englishWord: englishWord,
                russianWord: russianWord,
                count: count,
                probability: probability,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String englishWord,
                required String russianWord,
                Value<int?> count = const Value.absent(),
                Value<double?> probability = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion.insert(
                englishWord: englishWord,
                russianWord: russianWord,
                count: count,
                probability: probability,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      Word,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (Word, BaseReferences<_$AppDatabase, $WordsTable, Word>),
      Word,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
}
