import 'package:flutter/material.dart';

import 'package:news_app/Drawer/home_drawer.dart';
import 'package:news_app/home/category/category_details.dart';
import 'package:news_app/home/category/category_fragment.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/source_response/news_response.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/searchDelegate/search_delegate.dart';
import 'package:news_app/settings/setting_home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              selectedMenuItem == HomeDrawer.settings
                  ? AppLocalizations.of(context)!.settings
                  : selectedCategory == null
                      ? AppLocalizations.of(context)!.news_app
                      : getCategoryName(selectedCategory!, context),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            //------------------------
            actions: (
                    // selectedCategory = null &&
                    // selectedMenuItem = HomeDrawer.settings &&
                    newsObject == null)
                ? [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: MysearchDelegate(onTap: onNewsClick));
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 40,
                        ))
                  ]
                : []),

        // -----------------------

        drawer: Drawer(
          surfaceTintColor: MyTheme.blueColor,
          child: HomeDrawer(
            onSideMenueItemClick: onSideMenuItemClick,
          ),
        ),
        body: selectedMenuItem == HomeDrawer.settings
            ? const SettingScreen()
            : selectedCategory == null
                ? CategoryFragment(
                    onCategoryIconClick: onCategoryItemClick,
                  )
                : CategoryDetails(category: selectedCategory!),
      ),
    ]);
  }

  CategoryDM? selectedCategory;
  News? newsObject;

  void onCategoryItemClick(CategoryDM newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    selectedMenuItem = 0;
    newsObject = null;
    setState(() {});
  }

  int selectedMenuItem = HomeDrawer.categories;
  void onSideMenuItemClick(int newSelectedMenuItem) {
    selectedMenuItem = newSelectedMenuItem;
    selectedCategory = null;
    newsObject = null;
    Navigator.pop(context);
    setState(() {});
  }

  void onNewsClick(News newSelectedNews) {
    selectedMenuItem = 0;
    selectedCategory = null;
    newsObject = newSelectedNews;
    // print(newSelectedNews.title);
    setState(() {});
  }

  String getCategoryName(CategoryDM category, BuildContext context) {
    switch (category.id) {
      case 'sports':
        return AppLocalizations.of(context)!.sports_category;

      case 'technology':
        return AppLocalizations.of(context)!.technology_category;
      case 'business':
        return AppLocalizations.of(context)!.business_category;
      case 'entertainment':
        return AppLocalizations.of(context)!.entertainment_category;
      case 'health':
        return AppLocalizations.of(context)!.health_category;
      case 'science':
        return AppLocalizations.of(context)!.science_category;
      case 'general':
        return AppLocalizations.of(context)!.general_category;
      default:
        return '';
    }
  }
}
