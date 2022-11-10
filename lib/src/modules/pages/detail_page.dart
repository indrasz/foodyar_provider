import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant_detail.dart';
import 'package:foodyar/src/data/providers/detail_restaurant_provider.dart';
import 'package:foodyar/src/data/services/api_services.dart';
import 'package:foodyar/src/modules/widgets/customer_review_tile.dart';
import 'package:foodyar/src/res/res.dart';
import 'package:foodyar/src/utils/enums.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String? id;

  const DetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (context) => DetailRestaurantProvider(
        apiService: ApiService(),
        id: widget.id,
      ),
      // AppProvider(apiService: ApiService()).getRestaurant(id),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return screen(context, state.restResult, state);
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  // child: Text('${state.restaurant.restaurant}'),
                  child: Lottie.asset('assets/json/no_internet.json'),
                ),
              );
            } else {
              return const Center(
                child: Text('No data to displayed'),
              );
            }
          },
        ),
      ),
    );
  }

  menuList(List<dynamic> menus, MenuType menuType) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 32),
      sliver: SliverToBoxAdapter(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: menus.map((item) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputChip(
                      backgroundColor: kAvailableColor,
                      label: Text(
                        item.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              item.name,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  screen(BuildContext context, DetailRestaurantModel restaurant,
      DetailRestaurantProvider provider) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(restaurant.name),
            background: Hero(
              tag: restaurant.id,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                  restaurant.getLargePicture(),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/icon_star.png',
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: kGreyColor,
                        size: 16.0,
                      ),
                      Text(
                        restaurant.city,
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Category',
                    style: blackTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                    ),
                  ),
                  Row(
                    children: restaurant.categories
                        .map(
                          (item) => Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Chip(
                          backgroundColor: kInactiveColor,
                          label: Text(
                            item.name,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // NOTE: ABOUT
                  Text(
                    'About',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    restaurant.description,
                    style: blackTextStyle.copyWith(
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Food',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        menuList(restaurant.menus.foods, MenuType.food),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Drink',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        menuList(restaurant.menus.drinks, MenuType.drink),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Customer Review',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: restaurant.customerReviews
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomerReviewTile(
                      review: item,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
