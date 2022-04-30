import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Seller/blocs/shopBloc.dart';
import 'package:petswala/Seller/events/shopEvent.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class ShopProductCard extends StatelessWidget {
  final ShopProductItem product;
  final int index;
  ShopProductCard({this.product, this.index});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(index.toString()),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/productPage', arguments:product.id);
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
                      SizedBox(height: 4,),
                      Text(product.category,
                          style: AppFont.caption(AppColor.gray_dark)),
                      SizedBox(height: 8,),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColor.yellow,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('${product.rating}',
                            style: AppFont.caption(AppColor.yellow)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endActionPane:ActionPane(
        motion: ScrollMotion(),
    children: [
      SlidableAction(
        flex: 2,
        onPressed: (context) async{  
          ShopBloc bloc = BlocProvider.of<ShopBloc>(context);
          bloc.add(DeleteProductEvent(index: index));
        },
        label: 'Delete',
        icon: Icons.delete,
        backgroundColor: AppColor.red,
        foregroundColor: AppColor.white,
        ),
    ],
      ),
    
    );
  }
}