import 'package:flutter/material.dart';
import 'package:movie_app/movie/models/movie_model.dart';
import 'package:movie_app/movie/repository/movie_repository.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    final result = await _movieRepository.search(query: query);

    result.fold(
      (errorMessage) {
        _isLoading = false;
        _notifyListenersAfterBuild(
            context); // memberitahu gagal atau berhasil data di ambil
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
        return;
      },
      (response) {
        _movies.clear(); // menghapus data sebelumnya, sebelum di load ulang
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners(); // memberitahu gagal atau berhasil data di ambil
        return;
      },
    );
  }

  void _notifyListenersAfterBuild(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
