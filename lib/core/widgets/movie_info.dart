import 'package:filmle/app/views/bloc/get_movie_detail_bloc.dart';
import 'package:filmle/core/model/movie_detail_response.dart';
import 'package:filmle/core/style/colors.dart';
import 'package:flutter/material.dart';

import '../model/movie_detail.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  const MovieInfo({super.key, required this.id});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
    movieDetailBloc.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieDetailBloc.subject.stream,
      builder: ((context, AsyncSnapshot<MovieDetailResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildSuccessWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error as String);
        } else {
          return _buildLoadingWidget();
        }
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return Container();
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${detail.runtime} min",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: black),
        ),
        Container(
          width: 1.5,
          height: 14.0,
          color: grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        Text(
          detail.releaseDate ?? "",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: black),
        ),
      ],
    );
  }
}
