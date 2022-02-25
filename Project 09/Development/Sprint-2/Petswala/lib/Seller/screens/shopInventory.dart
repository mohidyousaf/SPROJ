import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:petswala/Seller/blocs/shopBloc.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/screens/addProduct.dart';
import 'package:petswala/Seller/screens/shopProductPage.dart';
import 'package:petswala/Seller/states/shopState.dart';

import 'package:petswala/Seller/widgets/sellerNavBars.dart';
import 'package:petswala/Seller/widgets/sellerProductCard.dart';
import 'package:petswala/Seller/widgets/sellerSearchBar.dart';

import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class ShopProvider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopBloc()..add(InitializeListEvent()),
        child: Builder(builder: (context) => 
        Navigator(
          initialRoute: '/shop',
          onGenerateRoute: (settings) {
            Widget page;
            switch (settings.name){
              case '/': page = Shop();break;
              case '/shop': page = Shop();break;
              case '/productPage': page = ProductPage();break;
              case '/addProduct': page = AddProduct();
            }
            return MaterialPageRoute(builder: (context) => page, settings: settings);
          },
        )
      )
    );
  }
}

class Shop extends StatelessWidget {
  final BuildContext context;

  Shop({this.context});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/addProduct');
        }, 
        backgroundColor: AppColor.primary, 
        child: Icon(Icons.add, color: AppColor.white,),),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Logo(color: AppColor.primary),
              SearchBarContainer(
                event: (text) => new ProductSearchEvent(searchString: text),
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              //     child: Text(
              //       'My Products',
              //       style: AppFont.h4Light(AppColor.color_font_dark),
              //     ),
              //   ),
              // ),
              Expanded(child: MyProducts())
            ],
          ),
        ),
      );
  }
}

class MyProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: SizedBox(
        // height: 353,
        child: BlocBuilder<ShopBloc, ShopState>(
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
                      itemBuilder: (context, index) => ShopProductCard(
                            product: state.displayedProducts[index], index: index,
                          ),
                      separatorBuilder: (context, int) => SizedBox(
                            height: 16,
                          ),
                      itemCount: state.displayedProducts.length),
                );
          },
        ),
      ),
    );
  }
}

