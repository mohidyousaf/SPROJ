import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:petswala/Seller/blocs/shopBloc.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/states/shopState.dart';

import 'package:petswala/Seller/widgets/sellerNavBars.dart';
import 'package:petswala/Seller/widgets/sellerProductCard.dart';
import 'package:petswala/Seller/widgets/sellerSearchBar.dart';

import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => ShopBloc()..add(InitializeListEvent()),
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Logo(color: AppColor.primary),
                SearchBarContainer(
                  event: (text) => new ProductSearchEvent(searchString: text),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      'Featured Products',
                      style: AppFont.h4Light(AppColor.color_font_dark),
                    ),
                  ),
                ),
                PersonalisedProducts()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonalisedProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: SizedBox(
        height: 353,
        child: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            return state.displayedProducts.length == 0
                ? Text('No products')
                : ListView.separated(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ShopProductCard(
                          product: state.displayedProducts[index],
                        ),
                    separatorBuilder: (context, int) => SizedBox(
                          width: 16,
                        ),
                    itemCount: state.displayedProducts.length);
          },
        ),
      ),
    );
  }
}

