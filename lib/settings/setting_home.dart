import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/my_theme.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:news_app/settings/language_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: MyTheme.primaryLightColor,
                  )),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: MyTheme.primaryLightColor,
                            fontSize: 20,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: MyTheme.primaryLightColor,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        side: BorderSide(
            color: MyTheme.primaryLightColor, width: 4, strokeAlign: 2),
      ),
      context: context,
      builder: (context) => const LanguageBottomSheetScreen(),
    );
  }
}
