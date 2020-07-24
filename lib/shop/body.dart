import 'package:flutter/material.dart';
import 'package:rescuefy/shop/constants.dart';
import 'package:rescuefy/shop/product.dart';
import 'package:rescuefy/screens/home/home.dart';
//import 'package:shop_app/screens/details/details_screen.dart';

import 'package:rescuefy/shop/categories.dart';
import 'package:rescuefy/shop/item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Order Food",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                                // product: products[index],
                                ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}
