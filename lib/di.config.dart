// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i3;

import 'data/repos/news_repo/data_sources/local_data_source/news_loacal_data_source_impl.dart'
    as _i5;
import 'data/repos/news_repo/data_sources/local_data_source/news_local_data_source.dart'
    as _i4;
import 'data/repos/news_repo/data_sources/remote_data_source/news_remote_data_source_impl.dart'
    as _i7;
import 'data/repos/news_repo/data_sources/remote_data_source/news_remote_data_sources.dart'
    as _i6;
import 'data/repos/news_repo/news_repo.dart' as _i8;
import 'data/repos/news_repo/news_repo_impl.dart' as _i9;
import 'third_party_packages_module.dart' as _i12;
import 'ui/screens/home/tabs/news/tab-details_view_model.dart' as _i10;
import 'ui/screens/home/tabs/news/tabs_list_view_model.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyPackagesModule = _$ThirdPartyPackagesModule();
    gh.factory<_i3.InternetConnectionChecker>(
        () => thirdPartyPackagesModule.provideInternetConnectionChecker);
    gh.factory<_i4.NewsLocalDataSource>(() => _i5.NewsLocalDataSourceImpl());
    gh.factory<_i6.NewsRemoteDataSource>(() => _i7.NewsRemoteDataSourceImpl());
    gh.factory<_i8.NewsRepo>(() => _i9.NewsRepoImpl(
          gh<_i6.NewsRemoteDataSource>(),
          gh<_i4.NewsLocalDataSource>(),
          gh<_i3.InternetConnectionChecker>(),
        ));
    gh.factory<_i10.TabDetailsViewModel>(
        () => _i10.TabDetailsViewModel(gh<_i8.NewsRepo>()));
    gh.factory<_i11.TabsListViewModel>(
        () => _i11.TabsListViewModel(gh<_i8.NewsRepo>()));
    return this;
  }
}

class _$ThirdPartyPackagesModule extends _i12.ThirdPartyPackagesModule {}
