import 'package:flutter/material.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDM {
  String id;
  String title;
  String imagePath;
  Color color;
  //var appLoc;
  CategoryDM({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.color,
  });
  /*
            
             technology
   */
  static List<CategoryDM> getCategoriesList(BuildContext context) {
    return [
      CategoryDM(
        id: 'sports',
        title: AppLocalizations.of(context)!.sports_category,
        imagePath: 'asset/images/ball.png',
        color: MyTheme.redColor,
      ),
      CategoryDM(
        id: 'general',
        title: AppLocalizations.of(context)!.general_category,
        imagePath: 'asset/images/global-news.png',
        color: MyTheme.darkBlueColor,
      ),
      CategoryDM(
        id: 'health',
        title: AppLocalizations.of(context)!.health_category,
        imagePath: 'asset/images/health.png',
        color: MyTheme.pinkColor,
      ),
      CategoryDM(
        id: 'business',
        title: AppLocalizations.of(context)!.business_category,
        imagePath: 'asset/images/business.png',
        color: MyTheme.brownColor,
      ),
      CategoryDM(
        id: 'entertainment',
        title: AppLocalizations.of(context)!.entertainment_category,
        imagePath: 'asset/images/entertainment.png',
        color: MyTheme.blackColor,
      ),
      CategoryDM(
        id: 'science',
        title: AppLocalizations.of(context)!.science_category,
        imagePath: 'asset/images/science.png',
        color: MyTheme.yellowColor,
      ),
      CategoryDM(
        id: 'technology',
        title: AppLocalizations.of(context)!.technology_category,
        imagePath: 'asset/images/Technology.png',
        color: Colors.cyan.shade600,
      ),
    ];
  }
}
