import 'package:filmle/app/views/bloc/get_movies_by_genre_bloc.dart';
import 'package:filmle/core/model/genre.dart';
import 'package:filmle/core/style/colors.dart';
import 'package:filmle/core/widgets/movie_by_genre.dart';
import 'package:flutter/material.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  const GenresList({Key? key, required this.genres}) : super(key: key);

  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc.drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310.0,
        child: DefaultTabController(
          length: widget.genres.length,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: white,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: maroon,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: grey,
                  labelColor: black,
                  isScrollable: true,
                  tabs: widget.genres.map((Genre genre) {
                    return Container(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Text((genre.name ?? "").toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.genres.map((Genre genre) {
                return GenreMovies(
                  genreId: genre.id ?? 0,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
