import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/checkoutBloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/events/checkoutEvent.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/CasualUser/states/checkoutState.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class Checkout1 extends StatelessWidget {
  const Checkout1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(context),
      body: Column(
        children: [
          Expanded(
            // flex: 1,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  // hasScrollBody: true,
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
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
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Shipping',
                            style: AppFont.h4Light(AppColor.color_font_dark),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Name',
                            style: AppFont.h5(AppColor.color_font_dark),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CustomTextField(
                                hintText: 'First',
                                initial: '',
                                func: CheckoutFuncs.changeFirstName),
                            SizedBox(
                              width: 16,
                            ),
                            CustomTextField(
                                hintText: 'Last',
                                initial: '',
                                func: CheckoutFuncs.changeSecondName),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Address',
                            style: AppFont.h5(AppColor.color_font_dark),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CustomTextField(
                                hintText: 'Address',
                                func: CheckoutFuncs.changeAddress),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: Row(
                          children: [
                            CustomTextField(
                                hintText: 'City',
                                func: CheckoutFuncs.changeCity),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: Row(
                          children: [
                            CustomTextField(
                              hintText: 'Country',
                              func: CheckoutFuncs.changeCountry,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart Total:',
                              style: AppFont.h5(AppColor.color_font_dark),
                            ),
                            Text(
                              'Rs.${state.getCartTotal}',
                              style: AppFont.h5(AppColor.color_font_dark),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      CheckoutBloc checkoutBloc = BlocProvider.of<CheckoutBloc>(context);                      
                      MarketPlaceBloc marBloc = BlocProvider.of<MarketPlaceBloc>(context);
                      marBloc.add(ConfirmOrderEvent(
                        firstName: checkoutBloc.state.firstName,
                        lastName: checkoutBloc.state.lastName,
                        address: checkoutBloc.state.address,
                        city: checkoutBloc.state.city,
                        country: checkoutBloc.state.country));

                      Navigator.of(context).pushNamed('/checkout2');
                    },
                    child: Container(
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.all_20,
                          color: AppColor.primary),
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Center(
                        child: Text('Complete Order',
                            style: AppFont.button(AppColor.white)),
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

class Checkout2 extends StatelessWidget {
  const Checkout2({Key key}) : super(key: key);

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
                'Your Order Details',
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
                  BlocBuilder<MarketPlaceBloc, MarketPlaceState>(
                  builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name:', style: AppFont.bodyLarge(AppColor.color_font_dark),),
                                Text('${state.order.name}', style: AppFont.bodyLarge(AppColor.color_font_dark),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Address:', style: AppFont.bodyLarge(AppColor.color_font_dark),)),
                                Expanded(
                                  child: Text('${state.order.address}, ${state.order.city}, ${state.order.country}', 
                                      style: AppFont.bodyLarge(AppColor.color_font_dark),
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      MarketPlaceBloc bloc = BlocProvider.of<MarketPlaceBloc>(context);
                      bloc.add(AddOrderEvent());
                    },
                    child:Container(
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.all_20,
                          color: AppColor.primary),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Center(
                        child: Text('Confirm Order', style: AppFont.button(AppColor.white)),
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

class CustomTextField extends StatelessWidget {
  final Function func;
  final hintText;
  final String initial;
  const CustomTextField({Key key, this.hintText, this.initial: '', this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return TextField(
            onChanged: (text) {
              func(context, text);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              fillColor: AppColor.gray_transparent,
              filled: true,
              hintText: hintText,
              labelText: hintText,
              hintStyle: AppFont.bodyLarge(AppColor.gray_light),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary),
                  borderRadius: AppBorderRadius.all_20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.gray_transparent),
                  borderRadius: AppBorderRadius.all_20),
            ),
          );
        },
      ),
    );
  }
}

class CheckoutFuncs {
  static void changeFirstName(context, text) {
    BlocProvider.of<CheckoutBloc>(context)
        .add(ChangeFirstNameEvent(name: text));
  }

  static void changeSecondName(context, text) {
    BlocProvider.of<CheckoutBloc>(context)
        .add(ChangeSecondNameEvent(name: text));
  }

  static void changeAddress(context, text) {
    BlocProvider.of<CheckoutBloc>(context)
        .add(ChangeAddressEvent(address: text));
  }

  static void changeCity(context, text) {
    BlocProvider.of<CheckoutBloc>(context).add(ChangeCityEvent(city: text));
  }

  static void changeCountry(context, text) {
    BlocProvider.of<CheckoutBloc>(context).add(ChangeCountryEvent(country: text));
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
            ],
          ),
        ),
      ),
    );
  }
}

