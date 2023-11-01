import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmle/ui/careousel_slider.dart';
import 'package:filmle/ui/loading_careousel_slider.dart';
import 'package:filmle/ui/movie_poster.dart';
import 'package:filmle/ui/search_view.dart';
import 'package:filmle/viewmodel/movie_provider.dart';
import 'package:filmle/viewmodel/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;

  @override
  Widget build(BuildContext context) {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              iconSize: 30.0,
              splashColor: Colors.white,
              highlightColor: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          'FILMLE',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              iconSize: 30.0,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: _movieProvider.movies != null
                    ? MovieCarouselSlider()
                    : const LoadingCarouselSlider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchWidget(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);

    Future<void> queryChange() async {
      searchProvider.query = query;
      await searchProvider.loadSuggestion();
      searchProvider.suggestionList.addAll(searchProvider.loadedSuggestionList);
    }

    if (query.isEmpty) {
      List<String> temp = searchProvider.recentList.toList();
      searchProvider.suggestionList = temp.reversed.toList();
    } else {
      if (query != searchProvider.query) {
        queryChange();
      }
    }

    return ListView.builder(
        itemCount: searchProvider.suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchProvider.suggestionList[index]),
            leading: query.isEmpty
                ? const Icon(Icons.access_time)
                : const SizedBox(),
            onTap: () {
              query = searchProvider.suggestionList[index];
              searchProvider.recentList.add(query);
              showResults(context);
            },
          );
        });
  }
}
