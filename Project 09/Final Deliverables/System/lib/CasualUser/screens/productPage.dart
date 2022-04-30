import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    return Scaffold(
    bottomNavigationBar: BottomNavBar(context),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: AppColor.primary,borderRadius: AppBorderRadius.all_25),
                        child: Center(child: Icon(CupertinoIcons.back,color: AppColor.white,size: 30,
                        ))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Logo(color: AppColor.primary)),
                ],
              ),
            ),
          ),
          BlocBuilder<MarketPlaceBloc, MarketPlaceState>(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: AppBorderRadius.all_50),
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(state.displayedProducts[index].imageUrl,fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Name:  ',style: AppFont.bodyLarge(AppColor.gray_dark)),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text('${state.displayedProducts[index].name}',
                                style:AppFont.bodyLarge(AppColor.black)),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Category:  ',style: AppFont.bodyLarge(AppColor.gray_dark)),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text('${state.displayedProducts[index].category}',
                                style:AppFont.bodyLarge(AppColor.black)),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Price:  ',style: AppFont.bodyLarge(AppColor.gray_dark)),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text('${state.displayedProducts[index].price}',
                                style:AppFont.bodyLarge(AppColor.black)),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          Text('Rating:  ',style: AppFont.bodyLarge(AppColor.gray_dark)),
                          Text('${state.displayedProducts[index].rating}', style: AppFont.bodyLarge(AppColor.black)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
          GestureDetector(
            onTap: () async {
              MarketPlaceBloc bloc = BlocProvider.of<MarketPlaceBloc>(context);
              bloc.add(AddToCartEvent(index:index));
              Navigator.of(context).pushReplacementNamed('/shoppingCart');
            },
            child: Container(
              width: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: AppBorderRadius.all_20, color: AppColor.primary),
              padding:EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Center(
                child: Text('Add to cart',style: AppFont.button(AppColor.white)),
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}