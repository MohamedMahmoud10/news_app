import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/app_router.dart';
import 'package:news_app/cubits/bottom_nav_bar/bottom_nav_bar_cubits.dart';
import 'package:news_app/cubits/dark_mode/dark_mode_cubit.dart';
import 'package:news_app/presntion_layer/screens/search.dart';

import 'config/dependency_injection.dart';
import 'cubits/bloc_observer.dart';
import 'cubits/news_cubit/news_cubit.dart';
import 'cubits/search/searc_cubit.dart';
import 'data_layer/api_services/api_services.dart';
import 'data_layer/repositry/repositry.dart';
import 'data_layer/theme_toggle/theme_toggle .dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeToggle.init();
  bool? isDark = ThemeToggle.getBool(key: 'isDark');
  Bloc.observer = MyBlocObserver();
  Repositry(ApiServices());
  setup();
  runApp(MyApp(
    appRouter: AppRouter(),
    isDark!,
  ));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  final AppRouter appRouter;

  MyApp(this.isDark, {super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => BottomNavBarCubit()),
        BlocProvider(
          create: (BuildContext context) => NewsCubit(
            Repositry(
              ApiServices(),
            ),
          ),
        ),
        BlocProvider(
            create: (BuildContext context) =>
                DarkModeCubit()..changeMode(fromShared: isDark)),
        BlocProvider(
          create: (context) => SearchCubit(
            Repositry(
              ApiServices(),
            ),
          ),
          child: const SerchWidget(),
        )
      ],
      child: BlocConsumer<DarkModeCubit, DarkModeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = DarkModeCubit.get(context);
          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                headlineSmall: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark),
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 20.0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                //selectedItemColor: Colors.teal,
                unselectedItemColor: Colors.black,
                selectedIconTheme: IconThemeData(size: 30, color: Colors.teal),
                //unselectedIconTheme: IconThemeData(color: Colors.black),
              ),
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                headlineSmall: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xFF121212),
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF121212),
                elevation: 0.0,
              ),
              scaffoldBackgroundColor: const Color(0xFF121212),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  elevation: 20.0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xFF121212),
                  selectedIconTheme:
                      IconThemeData(size: 30, color: Colors.teal),
                  unselectedItemColor: Colors.white
                  //unselectedIconTheme: IconThemeData(color: Colors.white),
                  ),
              primarySwatch: Colors.blue,
            ),
            themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.changeRouteSettings,
          );
        },
      ),
    );
  }
}
