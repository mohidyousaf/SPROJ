import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/screens/settings.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:petswala/Seller/widgets/chinbar.dart';
import 'package:petswala/CasualUser/widgets/productCard.dart';
import 'package:petswala/CasualUser/models/productItem.dart';


class SellerHome extends StatefulWidget {
  //const SellerHome({Key? key}) : super(key: key);

  @override
  _SellerHomeState createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  @override
  Widget build(BuildContext context) {
    //phone_height = 820.5714285714286
    double phone_height = MediaQuery.of(context).size.height;
    //phone_width = 411.42857142857144
    double phone_width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Logo(color: AppColor.primary,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: bottomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0,top: 30.0),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Hi! Mohid Yousaf",
                style: AppFont.h4(AppColor.primary),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              width: phone_width,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              color: Colors.white,
              height: phone_height*0.30,
              child: ListView(
                scrollDirection: Axis.horizontal,
               children: [
                 FlatButton(
                   onPressed: (){print("Card Pressed");},
                   child: Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     color: AppColor.primary_light,
                     child: Stack(
                       alignment: Alignment.bottomRight,
                       children: [
                         Column(
                           children: [
                             Container(
                               padding: EdgeInsets.only(top: 10.0,left: 15.0),
                               alignment: Alignment.bottomLeft,
                               width: phone_width*0.8506,
                               child: Text(
                                 "Todays Sales",
                                 style: AppFont.h4(AppColor.white),
                               ),
                             ),
                             SizedBox(height: 10.0,),
                             Container(
                               padding: EdgeInsets.only(top: 30.0,left: 15.0),
                               width: phone_width*0.8506,
                               //color: Colors.blue,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Container(padding: EdgeInsets.only(bottom: 15.0),child: Icon(CupertinoIcons.arrow_up,color: Colors.lightGreenAccent,size: 30,)),
                                   Text(
                                       "Rs. 570",
                                     style: AppFont.h3(AppColor.white),
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(height: 33.0),
                             Container(
                               width: phone_width*0.8506,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   Container(
                                     padding: EdgeInsets.only(right: 10.0),
                                     child: Icon(CupertinoIcons.forward,color: Colors.white,)
                                   )
                                 ],
                               ),
                             )
                           ],
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 50.0),
                             child: Image.asset("assets/transparent_paw.png"))
                       ],
                     )
                   ),
                 )
               ],
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0,left: 10.0),
              width: phone_width,
              color: Colors.white,
              child: Text(
                "Quick Actions",
                style: AppFont.h5(AppColor.primary),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: phone_width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: (){print("Customers printed");},
                      child: Container(
                        height: phone_width*0.1869,
                        width: phone_width*0.1869,
                        decoration: BoxDecoration(
                          color: AppColor.primary_dark,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ImageIcon(AssetImage("assets/icons/customers.png"),color: Colors.white,),
                      ),
                  ),
                   GestureDetector(
                     onTap: (){print("Deliveries printed");},
                     child: Container(
                       height: phone_width*0.1869,
                       width: phone_width*0.1869,
                       decoration: BoxDecoration(
                           color: AppColor.primary_dark,
                           borderRadius: BorderRadius.circular(10)
                       ),
                       child: ImageIcon(AssetImage("assets/icons/Delivery.png"),color: Colors.white,),
                     ),
                   ),
                  GestureDetector(
                    onTap: (){print("dollar printed");},
                    child: Container(
                      height: phone_width*0.1869,
                      width: phone_width*0.1869,
                      decoration: BoxDecoration(
                          color: AppColor.primary_dark,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ImageIcon(AssetImage("assets/icons/dollar.png"),color: Colors.white,),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){print("inventory printed");},
                    child: Container(
                      height: phone_width*0.1869,
                      width: phone_width*0.1869,
                      decoration: BoxDecoration(
                          color: AppColor.primary_dark,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ImageIcon(AssetImage("assets/icons/inventory.png"),color: Colors.white,),
                    ),
                  ),
                ],

              ),
            ),
            Container(width: phone_width,padding: EdgeInsets.only(top: 30.0,left: 10.0),child: Text("Recent Transactions",style: AppFont.h5(AppColor.primary),),),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index){
                  return Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lays",style: AppFont.bodySmall(AppColor.black),),
                            Text("12 Mar 2021",style: AppFont.caption(AppColor.gray_dark),)
                          ],
                        ),
                        Container(padding: EdgeInsets.only(left: phone_width*0.4772),child: Text("Rs. 2500",style: AppFont.bodyLarge(AppColor.black),),)
                      ],
                    )
                  );
                },
                separatorBuilder: (context,index){
                  return Divider(
                    thickness: 1,
                    indent: 15,
                    endIndent: 20,
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      )
    );
  }
}

