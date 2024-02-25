import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app/injector.dart';
import 'package:movie_app/movie/pages/movie_page.dart';
import 'package:movie_app/movie/providers/movie_get_discover_provider.dart';
import 'package:movie_app/movie/providers/movie_get_now_plyaing_provider.dart';
import 'package:movie_app/movie/providers/movie_get_top_provider.dart';
import 'package:movie_app/movie/providers/movie_search_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(const Main());
  FlutterNativeSplash.remove();
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<MovieGetDiscoverProvider>()),
        ChangeNotifierProvider(create: (_) => sl<MovieGetTopProvider>()),
        ChangeNotifierProvider(create: (_) => sl<MovieGetNowPlayingProvider>()),
        ChangeNotifierProvider(create: (_) => sl<MovieSearchProvider>()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 110, 117, 118)),
          useMaterial3: true,
        ),
        home: const MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
