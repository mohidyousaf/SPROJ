import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/CasualUser/widgets/productCard.dart';
import 'package:petswala/CasualUser/widgets/searchBar.dart';

import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class UserMarketplace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MarketPlaceBloc()..add(InitializeListEvent()),
        ),
      ],
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
                CategoryChips(),
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
        child: BlocBuilder<MarketPlaceBloc, MarketPlaceState>(
          builder: (context, state) {
            return state.displayedProducts.length == 0
                ? Text('No products')
                : ListView.separated(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProductCard(
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

class CategoryChips extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Color activeTextColor;
  final Color activeColor;
  final event;
  final List categories = ['All', 'Food', 'Toys', 'Furniture'];

  CategoryChips(
      {this.text,
      this.activeColor: AppColor.primary,
      this.activeTextColor: AppColor.white,
      this.color: AppColor.gray_transparent,
      this.textColor: AppColor.black,
      this.event});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) => categoryChip(index),
        separatorBuilder: (context, int) => SizedBox(width: 16),
      ),
    );
  }

  Widget categoryChip(int index) {
    MarketPlaceBloc bloc = BlocProvider.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          bloc.add(ChangeSelectionEvent(category: widget.categories[index]));
        });
        print(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.all_20,
          color: selectedIndex == index ? widget.activeColor : widget.color,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(widget.categories[index],
            textAlign: TextAlign.center,
            style: AppFont.bodyLarge(selectedIndex == index
                ? widget.activeTextColor
                : widget.textColor)),
      ),
    );
  }
}
