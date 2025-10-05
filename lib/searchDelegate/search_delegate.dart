import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/news/full_news_page.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MysearchDelegate extends SearchDelegate {
  Function onTap;

  MysearchDelegate({required this.onTap});

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: MyTheme.primaryLightColor,
      primaryIconTheme: IconThemeData(
        color: MyTheme.primaryLightColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MyTheme.primaryLightColor,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          // borderSide: BorderSide(
          //   color: MyTheme.primaryLightColor,
          // ),
          gapPadding: 10,
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: MyTheme.pinkColor),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = "";
              }
            },
            icon: const Icon(Icons.close))
      ];

  @override
  Widget buildResults(BuildContext context) => const Center();
  String? input;
  dynamic result;

  @override
  Widget buildSuggestions(BuildContext context) {
    input = query;

    return FutureBuilder(
      future: ApiManager.getNewsBySearch(searchArticle: input ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: MyTheme.primaryLightColor),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.something_went_wrong,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySearch(searchArticle: input ?? "");
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        MyTheme.primaryLightColor),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.data?.status != "ok") {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // snapshot.data!.message!,
                  AppLocalizations.of(context)!.write_to_search_results,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: MyTheme.blackColor,
                      ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySearch(searchArticle: input ?? "");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        }

        var newsList = snapshot.data?.articles ?? [];

        return newsList.isNotEmpty
            ? Stack(children: [
                Container(
                  color: MyTheme.whiteColor,
                  child: Image.asset(
                    'asset/images/pattern.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return NewsItem(
                              news: newsList[index],
                              onSearchTap: () {
                                Navigator.of(context).pushNamed(
                                    FullNewsScreen.routeName,
                                    arguments: newsList[index]);
                              });
                        },
                        itemCount: newsList.length,
                      ),
                    ))
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.do_not_disturb_on_outlined,
                    size: 200,
                    color: MyTheme.redColor,
                  ),
                  Text(
                    AppLocalizations.of(context)!.not_found,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.blackColor),
                  ),
                ],
              );
      },
    );
  }
}
