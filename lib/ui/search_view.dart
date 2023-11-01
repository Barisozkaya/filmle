import 'package:filmle/ui/detail_view.dart';
import 'package:filmle/viewmodel/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
