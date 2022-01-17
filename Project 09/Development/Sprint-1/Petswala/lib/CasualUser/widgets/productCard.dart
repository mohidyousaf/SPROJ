import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class ProductCard extends StatelessWidget {
  final ProductItem product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.secondary_light,
            borderRadius: AppBorderRadius.all_25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: AppBorderRadius.all_25),
              child: Image.asset(product.imageUrl),
              height: 235,
              width: 250,
              clipBehavior: Clip.hardEdge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: AppFont.bodyLarge(AppColor.black)),
                      Text(product.category,
                          style: AppFont.caption(AppColor.gray_dark)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs ${product.price}',
                      style: AppFont.h5(AppColor.primary)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}