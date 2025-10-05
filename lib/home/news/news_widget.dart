import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home/news/full_news_page.dart';
import 'package:news_app/home/news/news_item.dart';
import 'package:news_app/model/source_response/news_response.dart';
import 'package:news_app/model/source_response/source_response.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final scrollController = ScrollController();
  List<News> news = [];
  bool shouldLoadingNextPage = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          shouldLoadingNextPage = true;

          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shouldLoadingNextPage) {
      // pageNumber++;
      ApiManager.pageSize++;
      ApiManager.getNewsBySourceId(
        widget.source.id ?? '',
      ).then((newsResponse) => news.addAll(newsResponse?.articles ?? []));
      shouldLoadingNextPage = false;
      setState(() {});
    }
    return FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: MyTheme.primaryLightColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.something_went_wrong,
                  style: Theme.of(context).textTheme.titleMedium,
                  // 'Something went wrong'
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySourceId(widget.source.id ?? '');
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            );
          }
          //server response(success, error)
          if (snapshot.data?.status != 'ok') {
            return Column(
              children: [
                Text(snapshot.data!.message!),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySourceId(widget.source.id ?? '');
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.try_again,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            );
          }
          var newsList = snapshot.data?.articles ?? [];
          return ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(FullNewsScreen.routeName,
                      arguments: newsList[index]);
                },
                child: NewsItem(
                  news: newsList[index],
                  onSearchTap: () {
                    Navigator.of(context).pushNamed(FullNewsScreen.routeName,
                        arguments: newsList[index]);
                  },
                ),
              );
            },
            itemCount: newsList.length,
          );
        });
  }
}
