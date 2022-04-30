//import 'dart:html';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Authentication/addPet2.dart';
import 'package:petswala/CasualUser/blocs/postBloc.dart';
import 'package:petswala/CasualUser/blocs/userProfileBloc.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/events/userProfileEvent.dart';
import 'package:petswala/CasualUser/screens/settings.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/Seller/models/shopProductItem.dart';
import 'package:petswala/Seller/screens/home.dart';
import 'package:petswala/bloc/register_bloc.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/main.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:petswala/CasualUser/widgets/postCard.dart';
import 'package:petswala/CasualUser/models/postInfo.dart';
import 'package:petswala/CasualUser/widgets/productCard.dart';
import 'package:petswala/CasualUser/models/productItem.dart';
import 'package:petswala/Seller/widgets/sellerProductCard.dart';
import 'package:petswala/CasualUser/states/postState.dart';
import 'package:petswala/CasualUser/states/userProfileState.dart';
import 'package:images_picker/images_picker.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'package:image_picker/image_picker.dart';
// This is a user profile screen that is divided into posts, about and shopping and settings.

// class UserProfile extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   double containerHeight = 150;
//   double avatarHeight = 100;
//   String name;
//   int type = 0;
//
//   List<String> labels = ['posts', 'about', 'hopping'];
//
//   Future<Null> getSharedPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       name = prefs.getString("name");
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getSharedPrefs();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of<RegisterBLoc>(context);
//     double top = containerHeight - avatarHeight / 2;
//     return Scaffold(
//       appBar: _topBar(context),
//       bottomNavigationBar: BottomNavBar(context),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _profile(top, context),
//             SizedBox(height: 25),
//             GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTap: () {
//                 // switch the profile
//                 bottomDrawer(context);
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 alignment: Alignment.topRight,
//                 child: new Image.asset('assets/switch button.png'),
//               ),
//             ),
//             SizedBox(height: 70),
//             Container(
//               // width: MediaQuery.of(context).size.width,
//               child: ToggleSwitch(
//                 minWidth: 110,
//                 minHeight: 60.0,
//                 fontSize: 16.0,
//                 initialLabelIndex: 1,
//                 activeBgColor: [AppColor.primary],
//                 activeFgColor: Colors.white,
//                 inactiveBgColor: Colors.grey[100],
//                 inactiveFgColor: Colors.grey[900],
//                 totalSwitches: 3,
//                 cornerRadius: 20,
//                 labels: ['Posts', 'About', 'Shopping'],
//                 icons: [Icons.post_add, Icons.info, Icons.shopping_bag],
//                 onToggle: (index) {
//                   type = index.toInt();
//                   setState(() {});
//                   // return Column(
//                   //     children:
//                   //         (index == 0) ? [Text('hello')] : [Text('not hello')]);
//                   print("type is $type");
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 8),
//                 height: 100,
//                 color: AppColor.gray_transparent,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     symmetry('upload', '2', Icons.upload_file),
//                     VerticalDivider(color: AppColor.gray_dark),
//                     symmetry('favourites', '0', Icons.favorite),
//                     VerticalDivider(thickness: 1, color: AppColor.gray_dark),
//                     symmetry('comments', '0', Icons.comment)
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               width: MediaQuery.of(context).size.width,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: AppColor.gray_transparent,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'EMAIL',
//                     style: AppFont.button(AppColor.black),
//                   ),
//                   StreamBuilder<String>(
//                       stream: bloc.email,
//                       builder: (context, snapshot) {
//                         return snapshot.hasData
//                             ? Text(
//                                 snapshot.data,
//                                 style: AppFont.button(AppColor.black),
//                               )
//                             : Text(
//                                 'starrocket23@gmail.com',
//                                 style: AppFont.bodySmall(AppColor.black),
//                               );
//                       }),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               width: MediaQuery.of(context).size.width,
//               height: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: AppColor.gray_transparent,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Password',
//                     style: AppFont.button(AppColor.black),
//                   ),
//                   StreamBuilder<String>(
//                       stream: bloc.password,
//                       builder: (context, snapshot) {
//                         return snapshot.hasData
//                             ? Text(
//                                 snapshot.data,
//                                 style: AppFont.button(AppColor.black),
//                               )
//                             : Text(
//                                 '12345',
//                                 style: AppFont.bodySmall(AppColor.black),
//                               );
//                       }),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
Future<dynamic> bottomDrawer(BuildContext context) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            SizedBox(height: 20),
            ListTile(
                leading: Icon(
                  Icons.account_circle_rounded,
                  color: AppColor.primary_dark,
                ),
                dense: true,
                // tileColor: AppColor.primary,
                title: Text('User',
                    style: AppFont.bodySmall(AppColor.primary_dark)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            ListTile(
                leading: Icon(
                  Icons.monetization_on,
                  color: AppColor.primary_dark,
                ),
                dense: true,
                // tileColor: AppColor.primary,
                title: Text('Seller',
                    style: AppFont.bodySmall(AppColor.primary_dark)),
                onTap: () {
                  'pressed';
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SellerHome()));
                }),
          ],
        );
      });
}
//
//   Column symmetry(text1, text2, icon) {
//     return Column(
//       children: [
//         Icon(
//           icon,
//           color: AppColor.primary_dark,
//         ),
//         SizedBox(height: 12),
//         Text(text1, style: AppFont.bodySmall(AppColor.accent)),
//         Text(text2, style: AppFont.bodyLarge(AppColor.accent))
//       ],
//     );
//   }
//
//   AppBar _topBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//           icon: Image.asset('assets/back.png'),
//           onPressed: () {
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => HomeScreen()));
//           }),
//       backgroundColor: AppColor.white,
//       title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
//       actions: [
//         IconButton(
//             icon: Icon(
//               Icons.settings,
//               color: AppColor.primary_dark,
//             ),
//             onPressed: () => {
//                   Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (context) => Settings()))
//                 })
//       ],
//       centerTitle: true,
//       elevation: 0,
//     );
//   }
//
//   Widget _profile(double top, context) {
//     return Stack(
//       alignment: Alignment.center,
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: containerHeight,
//           decoration: BoxDecoration(color: AppColor.primary_light),
//         ),
//         Positioned(
//           top: top + 50,
//           child: Container(
//             height: 120,
//             width: MediaQuery.of(context).size.width,
//             // color: AppColor.white,
//             decoration: BoxDecoration(
//                 color: AppColor.white,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey, blurRadius: 5, offset: Offset(1, 3))
//                 ],
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30))),
//           ),
//         ),
//         Positioned(
//           left: 20,
//           top: top,
//           child: Container(
//             child: CircleAvatar(
//               radius: avatarHeight / 2 + 2,
//               backgroundColor: AppColor.gray_light,
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/User.png'),
//                 backgroundColor: AppColor.white,
//                 radius: avatarHeight / 2,
//               ),
//             ),
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           ),
//         ),
//         Positioned(
//             left: 24,
//             top: top + 120,
//             child: Container(
//                 child: Row(
//               children: [name==null ? Text(' '):Text(
//                   '   $name',
//                   style: AppFont.h5(AppColor.black),
//                 ),
//                 // IconButton(
//                 //     onPressed: () => {
//                 //           // edit name
//                 //         },
//                 //      icon: Icon(Icons.edit)),
//               ],
//             ))),
//       ],
//     );
//   }
// }

// Column(
//   children: (type == 1)
//       ? [
//           Row(
//             children: [
//               Container(
//                 child: Text('Posts'),
//               )
//             ],
//           )
//         ]
//       : [Text(labels[type])],
// )

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var _imageFile;
  var path;

  String name = '';
  String email = '';
  Uint8List image;

  List<ProductItem> animals = [
    ProductItem(name: 'Cats', category: 'Animal', price: 25.5, rating: 8.5)
  ];

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
    });
  }

  void checkEmail() async {
    await getSharedPrefs();
    NetworkHandler nw = NetworkHandler();
    print('name is ${name}');
    Map<String, dynamic> result = await nw.get('user/${name}');

    print('email is');
    print(result['data']['email']);

    setState(() {
      email = result['data']['email'];
      List<int> image_list = <int>[];
      try {
        List<dynamic> list = result['data']['img']['data']['data'];
        list.forEach((element) {
          image_list.add(element as int);
        });
        image = Uint8List.fromList(image_list);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getSharedPrefs();
    checkEmail();
  }

  @override
  Widget build(BuildContext context) {
    double phone_width = MediaQuery.of(context).size.width;
    final bloc = Provider.of<RegisterBLoc>(context);
    final product = ShopProductItem(
      name: 'Royal\'s Cat Food',
      category: 'Food',
      quantity: 5,
      price: 1500.00,
      rating: 4.5,
    );
    double phone_height = MediaQuery.of(context).size.height;
    List<String> info_type = ['Contact', 'Email', 'Address'];
    List<String> info_content = [
      '0320-5235453',
      'mohidyousaf@gmail.com',
      '255-Y,Phase 3, DHA, Lahore'
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc()..add(InitializationEvent()),
        ),
        BlocProvider(
            create: (context) => userProfileBloc()..add(InitializeUserInfo()))
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColor.green,
          appBar: AppBar(
            title: Logo(
              color: AppColor.primary,
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColor.green,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(builder: (context) => Settings()));
                  },
                  icon: Icon(
                    Icons.settings,
                    color: AppColor.primary,
                    size: 30.0,
                  ))
            ],
          ),
          bottomNavigationBar: BottomNavBar(context),
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: phone_width,
                    child: Image.asset(
                      'assets/coverphoto.png',
                    ),
                  ),
                  Container(
                    width: phone_width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 90.0,
                        ),
                        // Container(
                        //   height: 80.0,
                        //   width: 80.0,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     image: DecorationImage(image: AssetImage('assets/coverphoto.png')),
                        //     shape: BoxShape.circle,
                        //
                        //   ),
                        //   //child:  Image.asset('assets/coverphoto.png'),
                        // ),
                        Container(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: path == null
                                    ? image == null
                                        ? AssetImage('assets/User.png')
                                        : Image.memory(image).image
                                    : FileImage(File(path)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 70.0, left: 70.0),
                                child: Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: InkWell(
                                      onTap: () {
                                        print('pressed');
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            context: context,
                                            builder: ((builder) =>
                                                bottom_sheet(context)));
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColor.primary,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30.0),
                          child: name == ''
                              ? Text(
                                  'Mohid Yousaf',
                                  style: AppFont.h4(AppColor.black),
                                )
                              : Text('$name',
                                  style: AppFont.h5(AppColor.black)),
                        ),
                        Container(
                          width: phone_width * 0.65,
                          child: FlatButton(
                              onPressed: () {
                                bottomDrawer(context);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        email == ''
                                            ? Text(
                                                '....@gmail.com',
                                                style: AppFont.subtitle(
                                                    AppColor.gray_light),
                                              )
                                            : Text(
                                                email,
                                                style: AppFont.subtitle(
                                                    AppColor.gray_light),
                                              ),
                                        Container(
                                          child: Icon(
                                            CupertinoIcons.down_arrow,
                                            size: 15.0,
                                            color: AppColor.gray_light,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    endIndent: 10.0,
                                    indent: 10.0,
                                    thickness: 1.0,
                                  )
                                ],
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child:
                              TabBar(indicatorColor: AppColor.primary, tabs: [
                            Tab(
                              child: Text(
                                'Posts',
                                style: AppFont.subtitle(AppColor.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Shopping',
                                style: AppFont.subtitle(AppColor.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'About',
                                style: AppFont.subtitle(AppColor.black),
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                    ),
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 30.0),
                                child: BlocBuilder<PostBloc, PostState>(
                                    builder: (context, state) {
                                  return state.posts.length < 1
                                      ? Text("Loading")
                                      : ListView.separated(
                                          itemBuilder: (context, index) {
                                            return PostCard(
                                              post: state.posts[index],
                                              index: index,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: 10.0,
                                            );
                                          },
                                          itemCount: state.posts.length,
                                          shrinkWrap: true,
                                          primary: false,
                                        );
                                }),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              RecentDeliveries(context, phone_width),
                              OrderHistory(context, phone_width, product)
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Pets(context, phone_width),
                              Profileinfo(
                                  context, phone_width, info_type, info_content)
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pickPhoto() async {
    List<Media> res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.all,
      language: Language.System,
      maxTime: 30,
      // maxSize: 500,
      cropOpt: CropOption(
        // aspectRatio: CropAspectRatio.wh16x9,
        cropType: CropType.circle,
      ),
    );
    print(res);
    if (res != null) {
      print(res.map((e) => e.path).toList());
      setState(() {
        path = res[0].thumbPath;
        NetworkHandler nw = NetworkHandler();
        nw.patchImage('user/add/image', path);
      });
      // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
      // print(status);
    }
  }

  void takePhoto() async {
    List<Media> res = await ImagesPicker.openCamera(
      // pickType: PickType.video,
      pickType: PickType.image,
      quality: 0.8,
      maxSize: 800,
      // cropOpt: CropOption(
      //   aspectRatio: CropAspectRatio.wh16x9,
      // ),
      maxTime: 15,
    );
    print(res);
    if (res != null) {
      print(res[0].path);
      setState(() {
        path = res[0].thumbPath;
        NetworkHandler nw = NetworkHandler();
        nw.patchImage('user/add/image', path);
      });
    }
  }

  Widget bottom_sheet(context) {
    return Container(
      // color: AppColor.primary_light,
      height: 90,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: Column(
        children: <Widget>[
          Text('Choose profile picture',
              style: AppFont.bodyLarge(AppColor.accent)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto();
                    // if (path != null) {
                    //   NetworkHandler nw = NetworkHandler();
                    //   nw.patchImage('add/image', path);
                    // }
                  },
                  icon: Icon(
                    Icons.camera,
                    color: AppColor.primary_dark,
                  ),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColor.primary_dark),
                  )),
              TextButton.icon(
                  onPressed: () async {
                    // TakePhoto(ImageSource.gallery);
                    pickPhoto();
                    // if (path != null) {
                    //   NetworkHandler nw = NetworkHandler();
                    //   nw.patchImage('add/image', path);
                    // }
                  },
                  icon: Icon(
                    Icons.image,
                    color: AppColor.primary_dark,
                  ),
                  label: Text('Gallery',
                      style: TextStyle(color: AppColor.primary_dark)))
            ],
          )
        ],
      ),
    );
  }
}

Widget RecentDeliveries(context, phone_width) {
  return Container(
    padding: EdgeInsets.only(top: 30.0, left: 20.0),
    width: phone_width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Recent Deliveries',
              style: AppFont.h5(AppColor.primary),
            )),
        Container(
          height: 353,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16.0,
                );
              },
              itemCount: 100,
              itemBuilder: (context, index) {
                return ProductCard(
                    product: ProductItem(
                        name: 'Cats',
                        category: 'Animal',
                        price: 25.5,
                        rating: 8.5));
              }),
        ),
      ],
    ),
  );
}

Widget OrderHistory(context, phone_width, product) {
  return Container(
    padding: EdgeInsets.only(top: 30.0, left: 20.0),
    width: phone_width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order History',
          style: AppFont.h5(AppColor.primary),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ShopProductCard(
                product: product,
                index: 5,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.0,
              );
            },
            itemCount: 10,
            shrinkWrap: true,
            primary: false,
          ),
        )
      ],
    ),
  );
}

Widget Pets(context, phone_width) {
  return Container(
    padding: EdgeInsets.only(top: 30.0, left: 20.0),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pets',
                style: AppFont.h5(AppColor.primary),
              ),
              FlatButton(
                  onPressed: () {
                    print('Add Pets');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AddPet2()));
                  },
                  child: Container(
                    height: 41,
                    width: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.primary,
                    ),
                    child: Icon(
                      Icons.add,
                      color: AppColor.white,
                    ),
                  ))
            ],
          ),
        ),
        Container(
          height: 353,
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16.0,
                );
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return ProductCard(
                    product: ProductItem(
                        name: 'Cats',
                        category: 'Animal',
                        price: 25.5,
                        rating: 8.5));
              }),
        ),
      ],
    ),
  );
}

Widget Profileinfo(context, phone_width, info_type, info_content) {
  return Container(
    padding: EdgeInsets.only(top: 30.0, left: 20.0, bottom: 10.0),
    child: Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile Info',
                style: AppFont.h5(AppColor.primary),
              ),
              FlatButton(
                  onPressed: () {
                    print('Edit Personal Info');
                  },
                  child: Container(
                    height: 41,
                    width: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.primary,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: AppColor.white,
                    ),
                  ))
            ],
          ),
        ),
        Container(
          width: phone_width,
          child: BlocBuilder<userProfileBloc, UserInfoState>(
              builder: (context, state) {
            return state.user == null
                ? Text("")
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              info_type[0],
                              style: AppFont.subtitle(AppColor.black),
                            )),
                        Text(
                          "${state.user.contact_no}",
                          style: AppFont.caption(AppColor.gray_dark),
                        ),
                        Divider(
                          indent: 3,
                          endIndent: 3,
                          thickness: 1.5,
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              info_type[1],
                              style: AppFont.subtitle(AppColor.black),
                            )),
                        Text(
                          "${state.user.email}",
                          style: AppFont.caption(AppColor.gray_dark),
                        ),
                        Divider(
                          indent: 3,
                          endIndent: 3,
                          thickness: 1.5,
                        ),
                        Container(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              info_type[2],
                              style: AppFont.subtitle(AppColor.black),
                            )),
                        Text(
                          "${state.user.Address}",
                          style: AppFont.caption(AppColor.gray_dark),
                        ),
                        Divider(
                          indent: 3,
                          endIndent: 3,
                          thickness: 1.5,
                        )
                      ],
                    ),
                  );
          }),
        )
      ],
    ),
  );
}
