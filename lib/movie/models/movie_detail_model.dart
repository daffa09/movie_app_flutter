class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String status;
  final String tagline;
  final String title;
  final int revenue;
  final double voteAverage;
  final int voteCount;

  MovieDetailModel({
    required this.adult,
    this.backdropPath = '',
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath = '',
    required this.releaseDate,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.revenue,
  });

  factory MovieDetailModel.fromMap(Map<String, dynamic> json) =>
      MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        revenue: json["revenue"],
      );

  @override
  String toString() {
    return 'MovieDetailModel(adult: $adult, backdropPath: $backdropPath, budget: $budget, genres: $genres, homepage: $homepage, id: $id, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, status: $status, tagline: $tagline, title: $title, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}
