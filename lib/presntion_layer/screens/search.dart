import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/news_cubit/news_cubit.dart';
import 'package:news_app/cubits/search/searc_cubit.dart';
import 'package:news_app/cubits/search/search_state.dart';
import 'package:news_app/models/news_models.dart';

import '../widgets/widget.dart';

class SerchWidget extends StatefulWidget {
  const SerchWidget({Key? key}) : super(key: key);

  @override
  State<SerchWidget> createState() => _SerchWidgetState();
}

class _SerchWidgetState extends State<SerchWidget> {
  late List<Articles> allArticles;
  List<Articles> searchedArticles = [];
  bool _isSearching = false;
  final searchController = TextEditingController();

  Widget _buildAppBarSearch() {
    return TextField(
      controller: searchController,
      style: const TextStyle(
        fontSize: 20,
      ),
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
          hintText: 'Search For Character...',
          hintStyle: TextStyle(fontSize: 18),
          border: InputBorder.none),
      onChanged: (searchedCharacter) {
        addSearchedCharacterToList(searchedCharacter);
      },
    );
  }

  void addSearchedCharacterToList(String searchedCharacter) {
    searchedArticles = allArticles
        .where((character) =>
            character.title!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

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
    return const Text(
      'Home Screen',
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  @override
  void initState() {
    BlocProvider.of<NewsCubit>(context).getAllSportArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching
            ? const BackButton(
                color: Colors.grey,
              )
            : Container(),
        title: _isSearching ? _buildAppBarSearch() : _buildAppBarTitle(),
        backgroundColor: Colors.yellow,
        actions: _buildAppBarActions(),
      ),
      body: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          // var cubit = SearchCubit.get(context);
          if (state is SearchLoadingSuccess) {
            allArticles = (state).searchList;
            return Column(
              children: [
                SizedBox(
                  height: 340,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: allArticles.length,
                      itemBuilder: (context, index) => ResubleWidget(
                            articles: allArticles[index],
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breaking News',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        'More',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: allArticles.length,
                    itemBuilder: (context, index) => BreakingNews(
                      articles: allArticles[index],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
