import 'package:flutter/material.dart';
import 'package:movie_app/movie/models/movie_detail_model.dart';
import 'package:movie_app/movie/models/movie_model.dart';
import 'package:movie_app/widget/image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetail;

  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPosters;
  final double widthPosters;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget(
      {required this.heightBackdrop,
      required this.widthBackdrop,
      required this.widthPosters,
      required this.heightPosters,
      this.radius = 12.0,
      this.movie,
      this.movieDetail,
      this.onTap,
      super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc:
                '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ]),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc:
                      '${movieDetail != null ? movieDetail!.posterPath : movie!.posterPath}',
                  height: heightPosters,
                  width: widthPosters,
                  radius: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  movieDetail != null ? movieDetail!.title : movie!.title,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber),
                    Text(
                      '${movieDetail != null ? movieDetail!.voteAverage : movie!.voteAverage} (${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})',
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ))
        ],
      );
}
