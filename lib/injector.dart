import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/app_constants.dart';
import 'package:movie_app/movie/providers/movide_get_detail_provider.dart';
import 'package:movie_app/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_app/movie/providers/movie_get_now_plyaing_provider.dart';
import 'package:movie_app/movie/providers/movie_get_top_provider.dart';
import 'package:movie_app/movie/providers/movie_get_videos_provider.dart';
import 'package:movie_app/movie/providers/movie_search_provider.dart';
import 'package:movie_app/movie/repository/movie_repository.dart';
import 'package:movie_app/movie/repository/movie_repository_impl.dart';

// sl = service locator
final sl = GetIt.instance;

void setup() {
  // Register Provider
  sl.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(sl()),
  );
  sl.registerFactory<MovieGetTopProvider>(
    () => MovieGetTopProvider(sl()),
  );
  sl.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(sl()),
  );
  sl.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(sl()),
  );
  sl.registerFactory<MovieGetVideosProvider>(
    () => MovieGetVideosProvider(sl()),
  );
  sl.registerFactory<MovieSearchProvider>(
    () => MovieSearchProvider(sl()),
  );

  // Register Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl()),
  );

  // register http client (DIO)
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      ),
    ),
  );
}
