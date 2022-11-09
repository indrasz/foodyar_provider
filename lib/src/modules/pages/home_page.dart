import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/modules/provider/app_provider.dart';
import 'package:foodyar/src/modules/widgets/custom_sliver_appbar.dart';
import 'package:foodyar/src/res/res.dart';
import 'package:foodyar/src/utils/enums.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => AppProvider(
          apiService: ApiService(),
        ).getRestaurants(),
        child: CustomScrollView(
          slivers: [
            Consumer<AppProvider>(
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
            Consumer<AppProvider>(
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
                      state.result.restaurants
                          .map((restaurant) => item(context, restaurant),)
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
      ),
    );
  }

  Widget item(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return DetailScreen(restaurant: restaurant);
        // }));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              children: [
                Hero(
                    tag: restaurant.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: restaurant.getSmallPicture(),
                        width: 150,
                        height: 140,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (
                          context,
                          data,
                          _,
                        ) =>
                            const Center(
                          widthFactor: 0.5,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.visible,
                        ),
                        Text(
                          restaurant.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,
                            ),
                            Text(
                              "${restaurant.rating}",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.red,
                            ),
                            Text(restaurant.city),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black26,
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}
