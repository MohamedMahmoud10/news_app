import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/news_cubit/news_state.dart';

import '../../../cubits/news_cubit/news_cubit.dart';
import '../../widgets/widget.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  @override
  void initState() {
    //BlocProvider.of<NewsCubit>(context).getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        if (state is NewsLoadingDataSuccess) {
          return Column(
            children: [
              SizedBox(
                height: 340,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.articlesList.length,
                    itemBuilder: (context, index) => ResubleWidget(
                          articles: cubit.articlesList[index],
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
                    itemCount: cubit.articlesList.length,
                    itemBuilder: (context, index) => BreakingNews(
                          articles: cubit.articlesList[index],
                        )),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
