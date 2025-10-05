import 'package:flutter/material.dart';
import 'package:news_app/home/home_screen.dart';
import 'package:news_app/home/news/full_news_page.dart';
import 'package:news_app/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// shared_preferences: ^2.2.2

//4cf1f66a6cc74cd5ad322a49cc3ddbbe
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  late AppConfigProvider provider;

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    // intialPreferences();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        FullNewsScreen.routeName: (context) => FullNewsScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }

  // Future<void> intialPreferences() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? lang = prefs.getString('language');
  //   provider.changeLanguage(lang ??= "en");
  // }
}
