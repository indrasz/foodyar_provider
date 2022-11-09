import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/modules/provider/app_provider.dart';

class DetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Restaurant restaurant;
  final AppProvider provider;

  DetailSliverAppBar(
      {required this.expandedHeight,
      required this.restaurant,
      required this.provider});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Hero(
          tag: restaurant.id,
          child: CachedNetworkImage(
            imageUrl: restaurant.getMediumPicture(),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          child: SafeArea(
              child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )),
        ),
        Positioned(
          top: 150 - shrinkOffset,
          left: 8,
          right: 8,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(1),
                          icon: const Icon(Icons.info_outline),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(restaurant.name),
                              content: Text(
                                restaurant.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, "OK");
                                  },
                                  child: const Text('OK'),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.red,
                        ),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.amber,
                          ),
                          Text("${restaurant.rating}"),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.rate_review,
                            size: 18,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      restaurant.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  setState(AppProvider provider) {
    provider.getRestaurant(restaurant.id);
  }
}
