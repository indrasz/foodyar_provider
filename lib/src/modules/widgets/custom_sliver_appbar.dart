import 'package:flutter/material.dart';
import 'package:foodyar/src/data/providers/restaurant_provider.dart';
import 'package:foodyar/src/data/providers/search_restaurant_provider.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final SearchRestaurantProvider provider;

  CustomSliverAppBar({required this.expandedHeight, required this.provider});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/restaurant_small.jpeg',
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: -25,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  child: TextFormField(
                    // onChanged: (value) {
                    //   if (value.length >= 3) {
                    //     provider.onSearch(value);
                    //   } else if (value.isEmpty) {
                    //     provider.onSearch(value);
                    //   }
                    // },
                    decoration: const InputDecoration(
                        hintText: "Search restaurant or menu",
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, top: 15)),
                  ),
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
}
