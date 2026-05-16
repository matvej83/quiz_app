// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:quiz_app/app/di/modules/database_module.dart' as _i1034;
import 'package:quiz_app/app/router/app_router.dart' as _i223;
import 'package:quiz_app/features/dictionary/data/data_sources/dictionary_asset_data_source.dart'
    as _i976;
import 'package:quiz_app/features/dictionary/data/data_sources/dictionary_local_data_source.dart'
    as _i66;
import 'package:quiz_app/features/dictionary/data/database/app_database.dart'
    as _i316;
import 'package:quiz_app/features/dictionary/data/providers/database_provider.dart'
    as _i451;
import 'package:quiz_app/features/dictionary/services/dictionary_service.dart'
    as _i457;
import 'package:quiz_app/features/quiz/presentation/bloc/quiz_cubit.dart'
    as _i3;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i223.AppRouter>(() => _i223.AppRouter());
    gh.lazySingleton<_i976.DictionaryAssetDataSource>(
      () => _i976.DictionaryAssetDataSource(),
    );
    gh.lazySingleton<_i451.DatabaseProvider>(() => _i451.DatabaseProvider());
    await gh.factoryAsync<_i316.AppDatabase>(
      () => databaseModule.provideDatabase(gh<_i451.DatabaseProvider>()),
      preResolve: true,
    );
    gh.lazySingleton<_i66.DictionaryLocalDataSource>(
      () => _i66.DictionaryLocalDataSource(gh<_i316.AppDatabase>()),
    );
    gh.lazySingleton<_i3.QuizCubit>(
      () => _i3.QuizCubit(gh<_i66.DictionaryLocalDataSource>()),
    );
    gh.lazySingleton<_i457.DictionaryService>(
      () => _i457.DictionaryService(gh<_i976.DictionaryAssetDataSource>()),
    );
    return this;
  }
}

class _$DatabaseModule extends _i1034.DatabaseModule {}
