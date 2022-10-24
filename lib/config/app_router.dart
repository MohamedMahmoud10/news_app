import 'package:flutter/material.dart';
import 'package:news_app/contsans/strings/strings.dart';
import 'package:news_app/presntion_layer/screens/business_screen/business_screen.dart';
import 'package:news_app/presntion_layer/screens/layout_screen/layout_screen.dart';
import 'package:news_app/presntion_layer/screens/science_screen/science_screen.dart';
import 'package:news_app/presntion_layer/screens/settings_screen/settings_screen.dart';
import 'package:news_app/presntion_layer/screens/sports_screen/sports_screen.dart';

class AppRouter {
  // late Repositry repositry;
  // late NewsCubit newsCubit;
  // AppRouter() {
  //   repositry = Repositry(ApiServices());
  //   newsCubit = NewsCubit(repositry);
  // }

  Route? changeRouteSettings(RouteSettings settings) {
    switch (settings.name) {
      case layoutScreen:
        return MaterialPageRoute(builder: (_) => const LayoutScreen());
      case sportsScreen:
        return MaterialPageRoute(builder: (_) => const SportsScreen());
      case scienceScreen:
        return MaterialPageRoute(builder: (_) => const ScienceScreen());
      case businessScreen:
        return MaterialPageRoute(builder: (_) => BusinessScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      // case articleDetailScreen:
      //   return MaterialPageRoute(
      //       builder: (_) => ArticleDetailScreen(url: '',));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text(
                        'Something Go Wrong Please Connect To The InterNet'),
                  ),
                ));
    }
  }
}
