import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/dark_mode/dark_mode_cubit.dart';
import 'package:news_app/cubits/search/searc_cubit.dart';
import 'package:news_app/cubits/search/search_state.dart';

import '../../../models/news_models.dart';
import '../../widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Articles> allArticles;
  List<Articles> searchedArticles = [];
  bool _isSearching = false;
  final searchController = TextEditingController();

  Widget _buildAppBarSearch() {
    return TextField(
      controller: searchController,
      style: TextStyle(
        fontSize: 20,
        color: BlocProvider.of<DarkModeCubit>(context).isDarkMode
            ? Colors.black
            : Colors.white,
      ),
      cursorColor: BlocProvider.of<DarkModeCubit>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      decoration: InputDecoration(
          hintText: 'Search For News...',
          hintStyle: TextStyle(
            fontSize: 18,
            color: BlocProvider.of<DarkModeCubit>(context).isDarkMode
                ? Colors.black
                : Colors.white,
          ),
          border: InputBorder.none),
      onChanged: (searchedCharacter) {
        // addSearchedCharacterToList(searchedCharacter);
        BlocProvider.of<SearchCubit>(context)
            .getAllSearchList(searchedCharacter);
      },
    );
  }

  // void addSearchedCharacterToList(String searchedCharacter) {
  //   searchedArticles = allArticles
  //       .where((character) =>
  //           character.title!.toLowerCase().startsWith(searchedCharacter))
  //       .toList();
  //   setState(() {});
  // }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.grey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Home Screen',
      style: TextStyle(
          color: BlocProvider.of<DarkModeCubit>(context).isDarkMode
              ? Colors.black
              : Colors.white,
          fontSize: 20),
    );
  }

  var controoler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? BackButton(
                color: BlocProvider.of<DarkModeCubit>(context).isDarkMode
                    ? Colors.black
                    : Colors.white,
              )
            : Container(),
        title: _isSearching ? _buildAppBarSearch() : _buildAppBarTitle(),
        // backgroundColor: BlocProvider.of<DarkModeCubit>(context).isDark
        //     ? Colors.black
        //     : Colors.white,
        actions: _buildAppBarActions(),
      ),
      body: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          var allArticles = cubit.articlesSearchList;
          return SingleChildScrollView(
            child: Column(
              children: [
                // TextFormField(
                //   decoration: const InputDecoration(label: Text('Search')),
                //   controller: controoler,
                //   onChanged: (String value) {
                //     SearchCubit.get(context).getAllSearchList(value);
                //   },
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: allArticles.length,
                      itemBuilder: (context, index) => ResubleWidget(
                            articles: allArticles[index],
                          )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
