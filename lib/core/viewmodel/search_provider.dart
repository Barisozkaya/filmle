import 'package:filmle/core/model/movie.dart';
import 'package:flutter/material.dart';
import '../repository/search_repository.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepository _searchRepository = SearchRepository();

  String _query = '';
  String get query => _query;
  set query(String query) => _query = query;

  List<Movie>? _searchList = [];
  List<Movie>? get searchList => _searchList;

  List<String> _loadedSuggestionList = [];
  List<String> get loadedSuggestionList => _loadedSuggestionList;

  List<String> _suggestionList = [];
  List<String> get suggestionList => _suggestionList;
  set suggestionList(List<String> suggestionList) =>
      _suggestionList = suggestionList;

  final Set<String> _recentList = {};
  Set<String> get recentList => _recentList;

  loadSearch() async {
    List<Movie>? listSearchResult = await _searchRepository.loadSearch(query);
    _searchList = listSearchResult;
    notifyListeners();
  }

  loadSuggestion() async {
    suggestionList.clear();

    List<Movie>? listSuggestionResult =
        await _searchRepository.loadSearch(query);
    if (listSuggestionResult != null) {
      _loadedSuggestionList =
          listSuggestionResult.map((e) => e.title as String).toList();
    } else {
      _loadedSuggestionList.add('No Result!');
    }
    notifyListeners();
  }
}
