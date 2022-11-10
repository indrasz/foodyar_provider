import 'package:flutter/material.dart';
import 'package:foodyar/src/data/models/restaurant.dart';
import 'package:foodyar/src/modules/pages/detail_page.dart';
import 'package:foodyar/src/res/dimens.dart';
import 'package:foodyar/src/res/res.dart';

import 'bookmark_button.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({
    Key? key,
    required this.restaurant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailPage(id: restaurant.id);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
        ),
        width: 350,
        height: 221,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              restaurant.getMediumPicture(),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [BookmarkButton()],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 65,
            ),
            Text(
              restaurant.name,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
              ),
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
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}