import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:petswala/CasualUser/blocs/adoption_bloc.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/CasualUser/widgets/rescueCard.dart';
import 'package:petswala/Repository/channel_page.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PetPage extends StatefulWidget {
  const PetPage({ Key key}) : super(key: key);

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  ScrollController controller;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('hello: '+ModalRoute.of(context).settings.arguments);
    mongo.ObjectId petId = ModalRoute.of(context).settings.arguments;
    int index = BlocProvider.of<AdoptionBloc>(context).state.pets.indexWhere(
      (element) => element.petId == petId);
    PetInfo pet = index >= 0?BlocProvider.of<AdoptionBloc>(context).state.pets[index]:null;

    print(pet.ownerName);
    return Scaffold(
      bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomScrollView(
            controller: controller,
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  stretch: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                leading: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                    CupertinoIcons.back,
                    color: AppColor.color_font_dark,
                    size: 30,
                    ),
                  ),
                flexibleSpace: Container(
                  child: FlexibleSpaceBar(
                    background: CarouselSlider(
                      
                        options: CarouselOptions(
                          height: 350,
                          viewportFraction: 1,
                          // aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
                          ),
                        items: [
                          pet.category == 'Cat' ? 
                          Image.asset('assets/cat.png',fit: BoxFit.cover,width: MediaQuery.of(context).size.width,):
                          Image.asset('assets/images.jpg', width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)
                          ]
                      ),
                  ),
                ),
                ),
                SliverPersistentHeader(
                  delegate: Header(pet: pet),
                  pinned: true,),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0,0,0,70),
                  sliver: SliverList(
                    
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppBorderRadius.all_20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50, 
                                      width: 50,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: AppBorderRadius.all_25
                                      ),
                                      child: Image.asset('assets/cat.png'),
                                    ),
                
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: Text(pet.ownerName, style: AppFont.bodyLarge(AppColor.color_font_dark),),
                                    )
                                  ],
                                ),
                                Icon(CupertinoIcons.forward, color: AppColor.color_font_dark,)
                              ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            // height: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppBorderRadius.all_20),
                            child: Text('''Maximus is a super smart cat with so much love to give. He is well trained knows all commands sit, heal, go to your bed, stay on your bed, go to your crate, paw she knows it all.\n He is very protective and needs a experienced owner who keeps him in check. He loves to play with toys. He is a great fetcher and will be the most loyal cat you will ever know. We require that you meet with our trainer and that you take 15 training sessions with our trainer.''',
                                        overflow: TextOverflow.clip,maxLines: 30,style: AppFont.bodySmall(AppColor.color_font_dark),)
                          ),
                        ),
                        SizedBox(height: 16,),
                        ExpandableContainer(title: 'Location',child: Container(
                          height:350,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: AppBorderRadius.all_20),
                          child: GoogleMapScreen(location:LatLng(31.5204,74.3587))),),
                        // ExpandableContainer(),
                        // ExpandableContainer(),
                        // ExpandableContainer(),
                  ]
                              ),
                            ),
                ),
          ]
          ),
          Positioned(
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Row(
              children: [
                AbsorbPointer(
                  absorbing: loading,
                  child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            loading = true;
                          });
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String userID = prefs.getString('name');
                          StreamChatClient client = await getChatClient();
                          Channel channel = await navigateToChannel(client, userID, pet.ownerName);
                          print("Users: " +userID + " " + pet.ownerName);
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StandAloneChannelPage(),
                                    settings: RouteSettings(arguments: ChatArgs(channel: channel, client:client))),);
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_20
                          ),
                          child: loading?Container(height:30,width: 30,child: CircularProgressIndicator(color: Colors.white,)):Transform.rotate(
                            angle: -math.pi/4,
                            child: Icon(
                            Icons.send_rounded,
                            color: AppColor.white,
                            size: 30,
                            ),
                          ),
                        ),
                      ),
                ),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 60,
                        width: 300,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: AppBorderRadius.all_20
                        ),
                        child: Center(child: Text('Adopt Pet', style: AppFont.h5(AppColor.white)))
                      ),
                    ),
                
              ],
            ),
          ),
        ),
        ],
      )
    );
  }
}

class Header extends SliverPersistentHeaderDelegate{
 final PetInfo pet;
 Header({this.pet});
 
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(pet.name, style: AppFont.h4(AppColor.color_font_dark),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Icon(Icons.male, color: Colors.blue,),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(pet.category, style: AppFont.button(AppColor.gray_dark),),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                   Icon(Icons.favorite, color: AppColor.primary,),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical:16.0),
                     child: Text('${pet.years} years old', style: AppFont.button(AppColor.gray_dark),),
                   )
                ]
               
    
              )
          ],),
          Divider(color: AppColor.gray_light, thickness: 1,)
        ],
      )
    );
  }
  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


class ExpandableContainer extends StatefulWidget {
  final String title;
  final Widget child;
  const ExpandableContainer({ Key key, this.title, this.child}) : super(key: key);

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedContainer(  
                decoration: BoxDecoration(
          color: Colors.white,    
          borderRadius: AppBorderRadius.all_20
        ),            
        duration: Duration(milliseconds:50),
        height: expanded ? 440:75,
        child: GestureDetector(
          onTap: (){
            setState(() {
              expanded = !expanded;
              
            });
          },
          child:Padding(
            padding: const EdgeInsets.fromLTRB(16,16,16,16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title, style: AppFont.bodyLarge(AppColor.color_font_dark),),
                    expanded?Icon(Icons.keyboard_arrow_up, color: AppColor.color_font_dark,):
                            Icon(Icons.keyboard_arrow_down, color: AppColor.color_font_dark,),
                  ],
                ),
                expanded?Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0),
                  child: widget.child
                ):SizedBox(height: 0),
              ],
            ),
          )
        )
      ),
    );
  }
}