import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/Seller/blocs/shopBloc.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/widgets/sellerNavBars.dart';
import 'package:petswala/Seller/blocs/productBloc.dart';
import 'package:petswala/Seller/events/productEvent.dart';
import 'package:petswala/Seller/states/productState.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context);
    return BlocProvider(
      create: (context) => ProductBloc()..add(InitProductEvent()),
      child: Builder(
        builder: (context) => Scaffold(
        bottomNavigationBar: BottomNavBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          shopBloc.add(RefreshListEvent());
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(color: AppColor.primary, borderRadius: AppBorderRadius.all_25),
                            child: Center(child: Icon(CupertinoIcons.back, color: AppColor.white, size: 30,
                            ))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Logo(color: AppColor.primary)),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: AppBorderRadius.all_20),
                      height: 200,
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset('assets/uploadimage.png',fit: BoxFit.fill),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              Text('Name:  ', style: AppFont.bodyLarge(AppColor.gray_dark)),
                              ProductInput(hintText:'name', func: AddProductFuncs.changeName)
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              Text('Category:  ', style: AppFont.bodyLarge(AppColor.gray_dark)),
                              ProductInput(hintText:'category', func: AddProductFuncs.changeCategory)
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              Text('Price:  ', style: AppFont.bodyLarge(AppColor.gray_dark)),
                              ProductInput(hintText:'price(rs)', func: AddProductFuncs.changePrice)
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:MainAxisAlignment.start,
                            children: [
                              Text('Quzntity:  ', style: AppFont.bodyLarge(AppColor.gray_dark)),
                              ProductInput(hintText:'quantity', func: AddProductFuncs.changeQuantity)
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              GestureDetector(
                    onTap: () async {
                      Bloc bloc = BlocProvider.of<ProductBloc>(context);
                      bloc.add(AddProductEvent());
                      shopBloc.add(RefreshListEvent());
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: AppBorderRadius.all_20, color: AppColor.primary),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      child: Center(
                        child: Text('Add Product',style: AppFont.button(AppColor.white)),
                      ),
                    ),
                  )
            ],
          ),
        )),
      ),
    );
  }
}

class ProductInput extends StatelessWidget {
  final Function func;
  final hintText;
  const ProductInput({Key key,this.hintText, this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc,ProductState>(
      builder:(context, state) {
        return CustomTextFormField(func: func, hintText: hintText, isValid: state,);
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key, this.func, this.hintText, this.isValid
  }) : super(key: key);

  final Function func;
  final hintText;
  final isValid;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: TextFormField(
        onChanged: (text) {
          print(isValid.passIsValid);
          func(context, text);
        },
        decoration:InputDecoration(
          contentPadding:EdgeInsets.all(20),
          fillColor: AppColor.gray_transparent,
          filled: true,
          hintText:hintText,
          errorText: isValid.passIsValid ? null:'Wrong Input',
          hintStyle: AppFont.bodyLarge(AppColor.gray_light),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary),
              borderRadius:AppBorderRadius.all_20),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray_transparent),
              borderRadius: AppBorderRadius.all_20),
        ),
      ),
    );
  }
}

class AddProductFuncs{
  static void changeName(context, text){
    BlocProvider.of<ProductBloc>(context).add(ChangeNameEvent(name:text));
  }
   static void changeCategory(context, text){
    BlocProvider.of<ProductBloc>(context).add(ChangeCategoryEvent(category: text));
  }
  static void changePrice(context, text){
    BlocProvider.of<ProductBloc>(context).add(ChangePriceEvent(price: text));
  }
   static void changeQuantity(context, text){
    BlocProvider.of<ProductBloc>(context).add(ChangeQuantityEvent(quantity: text));
  }
}
