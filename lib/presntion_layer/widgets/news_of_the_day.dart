import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_models.dart';

import 'custom_tag.dart';
import 'image_container.dart';

class NewsOfTheDay extends StatelessWidget {
  const NewsOfTheDay({Key? key, required this.articles}) : super(key: key);
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
        height: MediaQuery.of(context).size.height * 0.40,
        imageProvide: imageProvide,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(
              backGrounColor: Colors.grey.withAlpha(150),
              children: const [
                Text(
                  'News of the Day',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              articles.title.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                height: 1.50,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () {},
              child: Row(
                children: const [
                  Text(
                    'Learn More',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
