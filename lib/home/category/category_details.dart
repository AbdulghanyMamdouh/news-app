import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/tab/tab_widget.dart';
import 'package:news_app/model/source_response/source_response.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDetails extends StatefulWidget {
  static const String routeName = 'category';
  final CategoryDM category;
  const CategoryDetails({super.key, required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.category.id),
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
              Text(AppLocalizations.of(context)!.something_went_wrong),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(widget.category.id);
                  setState(() {});
                },
                child: Text(AppLocalizations.of(context)!.try_again),
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
                  ApiManager.getSources(widget.category.id);
                  setState(() {});
                },
                child: Text(AppLocalizations.of(context)!.try_again),
              ),
            ],
          );
        }
        var sourceList = snapshot.data?.sources ?? [];
        return TabWidget(sourceList: sourceList);
      },
    );
  }
}
