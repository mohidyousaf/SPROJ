import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/CasualUser/screens/settings.dart';
import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:petswala/Seller/widgets/chinbar.dart';
import 'package:petswala/CasualUser/widgets/productCard.dart';
import 'package:petswala/CasualUser/models/productItem.dart';

class Store extends StatefulWidget{
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store>{
  @override
  int temp1=0;
  Widget build (BuildContext context){
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: bottomAppBar(context),
        body: Column(
          children: [
            Container(
              height: 242,
              width: MediaQuery.of(context).size.width,
              color: AppColor.primary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.edit,color: AppColor.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.0)),
                      Container(
                        height: 80.0,
                        width: 80.0,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset('assets/User.png'),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(

                              'Adil Store',
                              style: AppFont.bodySmall(AppColor.black),
                            ),
                            Text(
                              '222-k,Street # 1, Phase 5',
                              style: AppFont.bodySmall(AppColor.black),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 56.0)),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       width: 90.0,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  //       ),
                  //       child: TextButton(
                  //         onPressed: (){},
                  //         style: TextButton.styleFrom(
                  //           primary: Colors.black,
                  //           textStyle: AppFont.button(AppColor.black)
                  //         ),
                  //         child: const Text('Home'),
                  //       ),
                  //     ),
                  //     TextButton(
                  //         onPressed: (){},
                  //         style: TextButton.styleFrom(
                  //           primary: Colors.black,
                  //           textStyle: AppFont.button(AppColor.black)
                  //         ),
                  //         child: const Text('Products')),
                  //     TextButton(
                  //         onPressed: (){
                  //           temp1 =1;
                  //         },
                  //         style: TextButton.styleFrom(
                  //             primary: Colors.black,
                  //             textStyle: AppFont.button(AppColor.black)
                  //         ),
                  //         child: const Text('Reviews')),
                  //     TextButton(
                  //         onPressed: (){},
                  //         style: TextButton.styleFrom(
                  //             primary: Colors.black,
                  //             textStyle: AppFont.button(AppColor.black)
                  //         ),
                  //         child: const Text('About'))
                  //   ],
                  // )
                  TabBar(
                      tabs: [
                    Tab(
                      text: 'Homepage',
                      ),
                    Tab(
                      text: 'Products',
                    ),
                    Tab(
                      text: 'Reviews',
                    ),
                    Tab(
                     text: 'About',
                    )
                  ]
                  )
                ],
              ),
            ),
           Expanded(
             child: Container(
               child: TabBarView(
                 children: [
                   SingleChildScrollView(
                     physics: BouncingScrollPhysics(),
                     child: Column(
                       children: [
                         Padding(padding: EdgeInsets.only(top: 50.0)),
                         FlatButton(
                             onPressed: (){
                               print('Featured Items');
                             },
                             child: Container(
                               child: Row(
                                 children: [
                                   Text(
                                       'Featured Items',
                                     style: AppFont.h5(AppColor.black),
                                   ),
                                   Expanded(
                                       child: Container(
                                         padding: EdgeInsets.only(right: 15.0),
                                         alignment: Alignment.bottomRight,
                                     child: Icon(
                                       CupertinoIcons.forward,
                                     ),
                                   ))
                                 ],
                               ),
                             )
                         ),
                         Padding(padding: EdgeInsets.only(top: 10.0)),
                         Container(
                           height: 353,
                           child: ListView.separated(
                             physics: BouncingScrollPhysics(),
                             scrollDirection: Axis.horizontal,
                             separatorBuilder: (context,index){
                               return SizedBox(width: 16.0,);
                             },
                             itemCount: 100,
                             itemBuilder: (context,index){
                               return ProductCard(product: ProductItem(name: 'Cats',category: 'Animal',price: 25.5,rating: 8.5));
                             }
                           ),
                         ),
                         Padding(padding: EdgeInsets.only(top: 50.0)),
                         FlatButton(
                             onPressed: (){print('Categories');},
                             child: Container(
                               child: Row(
                                 children: [
                                   Text(
                                     'Categories',
                                     style: AppFont.h5(AppColor.black),
                                   ),
                                   Expanded(
                                     child: Container(
                                       padding: EdgeInsets.only(left: 15.0),
                                       alignment: Alignment.bottomRight,
                                       child: Icon(CupertinoIcons.forward),
                                     ),
                                   )
                                 ],
                               ),
                             )),
                         SizedBox(height: 20.0,),
                         Container(
                           width: MediaQuery.of(context).size.width,
                           child: ListView.separated(
                             shrinkWrap: true,
                               primary: false,
                               itemBuilder: (context,index){
                                 return Container(
                                   padding: EdgeInsets.only(left: 20.0),
                                   child: Text(
                                     'Category #1',
                                     style: AppFont.subtitle(AppColor.black),
                                   ),
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
                         )
                       ],
                     ),
                   ),
                   Text('Under Construction'),
                   Text('Under Construction'),
                   Text('Under Construction'),
                 ],

               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}

