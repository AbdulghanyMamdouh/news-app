import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:news_app/model/source_response/news_response.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher_web/url_launcher_web.dart' as webLaunch;

// ignore: must_be_immutable
class FullNewsScreen extends StatelessWidget {
  static const String routeName = 'full_news';

  FullNewsScreen({super.key});
  late AppConfigProvider provider;
  // final News news;
  /*
  Stack(children: [
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
        // appBar: AppBar(
        //     title: Text(
        //       'News',
        //       style: Theme.of(context).textTheme.titleLarge,
        //     ),
        //     //------------------------
        //     actions: (selectedCategory != null &&
        //             selectedMenuItem != HomeDrawer.settings &&
        //             newsObject == null)
        //         ? [
        //             IconButton(
        //                 onPressed: () {
        //                   showSearch(
        //                       context: context,
        //                       delegate: MysearchDelegate(onTap: onNewsClick));
        //                 },
        //                 icon: const Icon(
        //                   Icons.search,
        //                   size: 40,
        //                 ))
        //           ]
        //         : []),
       
        //-----------------------

        // drawer: Drawer(
        //   child: HomeDrawer(
        //     onSideMenueItemClick: onSideMenuItemClick,
        //   ),
        // ),
        body:
   */
  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)!.settings.arguments as News;
    provider = Provider.of<AppConfigProvider>(context);
    return Stack(children: [
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
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.news_title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 4,
            right: 4,
            top: 32,
            bottom: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.fill,
                    imageUrl: news.urlToImage ??
                        // " https://www.tigren.com/blog/wp-content/uploads/2021/11/how-to-fix-the-requested-url-was-not-found-on-this-server-1.jpg",
                        "https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/d27f57afb7ac3501d4d69ce6afff190b.jpg", // Provide a fallback empty string if urlToImage is null
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  news.author ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(news.title ?? ''),
                Text(
                    timeago.format(
                        DateTime.now().subtract(
                          Duration(
                              hours: DateTime.parse(news.publishedAt!).minute),
                        ),
                        locale: provider.appLanguage,
                        allowFromNow: true),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.end),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(news.content ?? ''),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                InkWell(
                  onTap: () {
                    launch.launchUrl(
                        Uri.parse(news.url ?? 'https://flutter.dev'),
                        mode: LaunchMode.externalApplication);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.view_full_article,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          launch.launchUrl(
                              Uri.parse(news.url ?? 'https://flutter.dev'),
                              mode: LaunchMode.externalApplication);
                          // launchURL(news.url ?? 'https://www.geeksforgeeks.org/');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  // int calculateTimeAgo(News news) {
  //   String? dateString = news.publishedAt;
  //   if (dateString == null) {
  //     return 0;
  //   }

  //   DateFormat format =
  //       DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'", provider.appLanguage);
  //   DateTime dateTime = format.parse(dateString);
  //   int nDateTime = dateTime.millisecondsSinceEpoch;
  //   int timeAgo = DateTime.now().millisecondsSinceEpoch - nDateTime;

  //   return (timeAgo ~/
  //       (1000 * 3600)); // Convert millisecondsSinceEpoch to hours
  // }

  // Future<void> launchURL(String url) async {
  //   if (await canLaunchUrlString(url)) {
  //     await launchUrlString(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
