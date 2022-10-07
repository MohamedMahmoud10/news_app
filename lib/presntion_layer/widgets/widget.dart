import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/news_cubit/news_cubit.dart';
import 'package:news_app/models/news_models.dart';

import '../../cubits/news_cubit/news_state.dart';
import 'image_container.dart';
import 'news_of_the_day.dart';

class ResubleWidget extends StatelessWidget {
  final Articles articles;

  const ResubleWidget({
    Key? key,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsStates>(
      builder: (context, state) {
        return Column(
          children: [
            NewsOfTheDay(
              articles: articles,
            ),
          ],
        );
      },
    );
  }
}

class BreakingNews extends StatelessWidget {
  const BreakingNews({
    super.key,
    required this.articles,
  });

  final Articles articles;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) => const Text(''),
      placeholder: (context, url) => const CircularProgressIndicator(),
      imageUrl: '${articles.urlToImage}',
      imageBuilder: (context, imageProvide) => ImageContainer(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        imageProvide: imageProvide,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }
}
