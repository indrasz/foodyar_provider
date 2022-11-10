import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/modules/pages/detail_page.dart';
import 'package:foodyar/src/data/providers/restaurant_provider.dart';
import 'package:foodyar/src/modules/widgets/custom_sliver_appbar.dart';
import 'package:foodyar/src/modules/widgets/restaurant_tile.dart';
import 'package:foodyar/src/res/res.dart';
import 'package:foodyar/src/utils/enums.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Consumer<RestaurantProvider>(
            builder: (context, provider, _) {
              return SliverPersistentHeader(
                delegate: CustomSliverAppBar(
                  expandedHeight: 250,
                  provider: provider,
                ),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    state.restResult.restaurants
                        .map((restaurant) => RestaurantTile(restaurant: restaurant))
                        .toList(),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return SliverFillRemaining(
                  child: Center(
                    child: Lottie.asset('assets/json/no_internet.json'),
                  ),
                );
              } else {
                return SliverFillRemaining(
                  child: Center(
                    child: Lottie.asset('assets/json/search_empty.json'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Widget item(BuildContext context, Restaurant restaurant) {
  //   return RestaurantTile(restaurant: restaurant);
  // }
}
