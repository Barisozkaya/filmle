import 'package:auto_route/annotations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmle/ui/detail_view.dart';
import 'package:filmle/viewmodel/movie_provider.dart';
import 'package:filmle/viewmodel/search_provider.dart';
import 'package:filmle/viewmodel/trending_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  late TrendingProvider _trendingProvider;

  @override
  Widget build(BuildContext context) {
    final _movieProvider = context.read<MovieProvider>();
    final trendingProvider = context.read<TrendingProvider>();
    _movieProvider.loadMovies();
    final _trendingProvider = context.read<TrendingProvider>();
    _trendingProvider.loadMovies();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )),
        centerTitle: true,
        title: const Text(
          'TMDB',
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
                    child: Text(
                      'Cinema Now',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: _movieProvider.movies != null
                    ? MovieCarouselSlider()
                    : const LoadingCarouselSlider(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Row(
                  children: [
                    Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MoviePoster(provider: _trendingProvider),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  var provider;

  MoviePoster({required this.provider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.movies.length,
            itemBuilder: (BuildContext context, int idx) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(movie: provider.movies[idx])));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      provider.movies[idx].postUrl,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class MovieCarouselSlider extends StatelessWidget {
  MovieCarouselSlider({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;
  // late DotsIndicatorProvider _dotsIndicatorProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 0.60,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
      ),
      items: _movieProvider.movies!.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              movie: item,
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  item.postUrl,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class LoadingCarouselSlider extends StatelessWidget {
  const LoadingCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: 380.0,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
      items: [0, 0, 0].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16.0)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }).toList(),
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

class SearchWidget extends StatelessWidget {
  late String query;
  SearchWidget({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    searchProvider.query = query;

    searchProvider.loadSearch();
    if (query != '') {
      searchProvider.recentList.add(query);
    }
    if (searchProvider.searchList != null) {
      return ListView.separated(
          itemCount: searchProvider.searchList!.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white70,
              ),
          itemBuilder: (BuildContext context, int idx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                            movie: searchProvider.searchList![idx])));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Image.network(
                      searchProvider.searchList![idx].postUrl,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.28,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          searchProvider.searchList![idx].title!,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return const Center(
        child: Text(
          'Oops! There is no result!',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }
  }
}
