import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/bottom_nav_bar/bottom_nav_bar_cubits.dart';
import 'package:news_app/cubits/bottom_nav_bar/bottom_nav_bar_states.dart';
import 'package:news_app/cubits/dark_mode/dark_mode_cubit.dart';

import '../search.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavBarCubit, BottomNavBarStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = BottomNavBarCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SerchWidget()));
                  },
                  icon: const Icon(Icons.search)),
              BlocConsumer<DarkModeCubit, DarkModeState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  var cubit = DarkModeCubit.get(context);
                  return IconButton(
                      onPressed: () {
                        cubit.changeMode();
                      },
                      icon: Icon(cubit.isDark
                          ? Icons.dark_mode_outlined
                          : Icons.sunny));
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (int index) => cubit.changeNavBarItems(index),
            currentIndex: cubit.curentIndex,
          ),
          body: cubit.screens[cubit.curentIndex],
        );
      },
    );
  }
}
