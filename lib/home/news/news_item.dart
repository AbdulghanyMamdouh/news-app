import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/model/source_response/news_response.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
// import 'package:news_app/my_theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;
  final Function onSearchTap;
  NewsItem({super.key, required this.news, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: () {
        onSearchTap();
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Image.asset(news.urlToImage ?? ''),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.fill,
                imageUrl: news.urlToImage == null
                    ? "https://s.yimg.com/ny/api/res/1.2/2wu2XnUhhNGGKSbCL8_FmQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2022-09/6be0e290-39fe-11ed-a7b7-d9f37772c112"
                    : urlRegex.hasMatch(news.urlToImage!)
                        ? news.urlToImage!
                        : "https://s.yimg.com/ny/api/res/1.2/2wu2XnUhhNGGKSbCL8_FmQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2022-09/6be0e290-39fe-11ed-a7b7-d9f37772c112",
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              news.author ?? '',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            Text(
              news.title ?? '',
              // style: TextStyle(
              //   fontSize: ,
              //   fontWeight: FontWeight.w400,
              //   color: Colors.grey,
              // ),
            ),
            Text(
              timeago.format(
                  DateTime.now().subtract(
                    Duration(hours: DateTime.parse(news.publishedAt!).minute),
                  ),
                  locale: provider.appLanguage,
                  allowFromNow: true),
              // '${calculateTimeAgo(news)}h ago',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  // int calculateTimeAgo(News news) {
  //   String? dateString = news.publishedAt;
  //   if (dateString == null) {
  //     return 0;
  //   }
  //   DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  //   DateTime dateTime = format.parse(dateString);
  //   int nDateTime = dateTime.millisecondsSinceEpoch;
  //   int timeAgo = DateTime.now().millisecondsSinceEpoch - nDateTime;
  //   return (timeAgo ~/ (1000 * 3600)); // Convert milliseconds to hours
  // }

  final RegExp urlRegex = RegExp(
    r'^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\+#]*[\w\-@?^=%&/~\+#]$',
    caseSensitive: false,
  );

  Future<bool> loadImage(String? url) async {
    if (url == null || !urlRegex.hasMatch(url)) {
      return false; // Return null for invalid URLs
    }
    return true;
  }
}
