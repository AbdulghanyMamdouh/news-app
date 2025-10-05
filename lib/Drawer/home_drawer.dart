import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  final Function onSideMenueItemClick;
  static const int categories = 1;
  static const int settings = 2;
  const HomeDrawer({
    super.key,
    required this.onSideMenueItemClick,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: MyTheme.primaryLightColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.23,
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.news_app,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.08,
            left: MediaQuery.of(context).size.width * 0.08,
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          child: InkWell(
            onTap: () {
              ApiManager.pageSize = 1;

              onSideMenueItemClick(categories);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.list,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.categories,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.08,
            left: MediaQuery.of(context).size.width * 0.08,
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          child: InkWell(
            onTap: () {
              ApiManager.pageSize = 1;

              onSideMenueItemClick(settings);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.settings,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.settings,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
