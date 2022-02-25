import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class ShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(context),
      // backgroundColor: AppColor.primary,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_25),
                        child: Center(
                            child: Icon(
                          CupertinoIcons.back,
                          color: AppColor.white,
                          size: 30,
                        ))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Logo(color: AppColor.primary)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'My Cart',
                style: AppFont.h4Light(AppColor.color_font_dark),
              ),
            ),
          ),
          Expanded(child: Products()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.all_25,
                        color: AppColor.secondary_light),
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                children: [
                  BlocBuilder<MarketPlaceBloc, MarketPlaceState>(
                  builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Cart Total:', style: AppFont.h5(AppColor.color_font_dark),),
                            Text('Rs.${state.getCartTotal}', style: AppFont.h5(AppColor.color_font_dark),),
                          ],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      // MarketPlaceBloc bloc = BlocProvider.of<MarketPlaceBloc>(context);
                      Navigator.of(context).pushNamed('/checkout1');


                    },
                    child:Container(
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.all_20,
                          color: AppColor.primary),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Center(
                        child: Text('Checkout', style: AppFont.button(AppColor.white)),
                      ),
                    ),
                  ),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: SizedBox(
        // height: 353,
        child: BlocBuilder<MarketPlaceBloc, MarketPlaceState>(
          builder: (context, state) {
            return state.displayedProducts.length == 0
                ? Text('Loading ... ')
                : MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => CartProductCard(
                              product: state.order.cartItems[index],
                              index: index,
                            ),
                        separatorBuilder: (context, int) => SizedBox(
                              height: 16,
                            ),
                        itemCount: state.order.cartItems.length),
                  );
          },
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final ProductItem product;
  final index;
  CartProductCard({this.product, this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/productPage', arguments: index);
      },
      child: Container(
        // height: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.secondary_light,
            borderRadius: AppBorderRadius.all_25),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: AppBorderRadius.all_15),
                child: Image.asset(product.imageUrl),
                height: 75,
                clipBehavior: Clip.hardEdge,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: AppFont.bodyLarge(AppColor.black)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(product.category,
                        style: AppFont.caption(AppColor.gray_dark)),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Rs.${product.price}',
                            style: AppFont.bodyLarge(AppColor.primary)),
                      ],
                    )
                  ],
                ),
              ),
              BlocBuilder<MarketPlaceBloc, MarketPlaceState>(
                builder: (context, state) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                MarketPlaceBloc bloc = BlocProvider.of(context);
                                bloc.add(IncQuantityEvent(index:index));
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: AppBorderRadius.all_15,
                                    color: AppColor.primary),
                                child: Center(
                                    child: Text(
                                  '+',
                                  style: AppFont.bodyLarge(AppColor.white),
                                )),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '${product.quantity}',
                              style:
                                  AppFont.bodyLarge(AppColor.color_font_dark),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                                MarketPlaceBloc bloc = BlocProvider.of(context);
                                bloc.add(DecQuantityEvent(index:index));
                              },
                            child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                borderRadius: AppBorderRadius.all_15,
                                color: AppColor.primary),
                            child: Center(
                                child: Text(
                              '-',
                              style: AppFont.bodyLarge(AppColor.white),
                            )),
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
