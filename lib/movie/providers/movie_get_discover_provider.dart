import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/movie/models/movie_model.dart';
import 'package:movie_app/movie/repository/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get iSloading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    final result = await _movieRepository.getDiscover();

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
        return null;
      },
    );
  }

  void getDiscoverWithPaging(BuildContext context,
      {required PagingController pagingController, required int page}) async {
    final result = await _movieRepository.getDiscover(page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));

        pagingController.error = errorMessage;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
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
