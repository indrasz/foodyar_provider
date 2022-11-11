import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/data/providers/search_restaurant_provider.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/modules/pages/detail_page.dart';
import 'package:foodyar/src/data/providers/restaurant_provider.dart';
import 'package:foodyar/src/modules/pages/search_page.dart';
import 'package:foodyar/src/modules/widgets/custom_sliver_appbar.dart';
import 'package:foodyar/src/modules/widgets/restaurant_tile.dart';
import 'package:foodyar/src/res/res.dart';
import 'package:foodyar/src/utils/enums.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final queryC = TextEditingController();

  @override
  void dispose() {
    queryC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            toolbarHeight: 100.0 + kToolbarHeight,
            centerTitle: true,
            backgroundColor: kUnavailableColor,
            pinned: true,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: kGreyColor,
                      ),
                      onPressed: () {},
                    ),
                    Container(
                      width: 80,
                      height: 50,
                      decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/icon_logo.png',
                              ),
                            ),
                          ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: kGreyColor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      controller: queryC,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kWhiteColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kWhiteColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SearchPage(query: queryC.text);
                                },
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.search,
                            color: kGreyColor,
                          ),
                        ),
                        hintText: 'Search  Restaurant',
                        hintStyle: blackTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                        .map((restaurant) =>
                            RestaurantTile(restaurant: restaurant))
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
}
