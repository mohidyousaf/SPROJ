import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/screens/servicesHome.dart';
// import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
// import 'package:petswala/CasualUser/events/userMarketplaceEvent.dart';
// import 'package:petswala/CasualUser/states/userMarketplaceState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Repository/channel_page.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:petswala/Widgets/button.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key key}) : super(key: key);

  final ServiceInfo service = ServiceInfo(
      name: 'Adil',
      rate: 120,
      description:
          "Dedicated veterinarian seeking positions in the Seattle area. Skilled in treating animals, working in high-pressure environments and problem-solving. Passionate about educating pet owners on their pets' health and well-being, as well as advocating for animal rights.",
      type: 'Vet',
      imLink: 'assets/5506680.jpg');
  @override
  Widget build(BuildContext context) {
    ServiceInfo service =
        ModalRoute.of(context).settings.arguments as ServiceInfo;
    return Scaffold(
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: AppBorderRadius.all_50),
                    height: 200,
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      service.imLink,
                      fit: BoxFit.fill,
                    ),
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
                            Text('Name:  ',
                                style: AppFont.bodyLarge(AppColor.gray_dark)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('${service.name}',
                                  style: AppFont.bodyLarge(AppColor.black)),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text('Description:  ',
                                    style:
                                        AppFont.bodyLarge(AppColor.gray_dark))),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${service.description}',
                                  style: AppFont.bodyLarge(AppColor.black),
                                  overflow: TextOverflow.fade,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Type:  ',
                                style: AppFont.bodyLarge(AppColor.gray_dark)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('${service.type}',
                                  style: AppFont.bodyLarge(AppColor.black)),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Price:  ',
                                style: AppFont.bodyLarge(AppColor.gray_dark)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text('${service.rate}/hr',
                                  style: AppFont.bodyLarge(AppColor.black)),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Rating:  ',
                                  style: AppFont.bodyLarge(AppColor.gray_dark)),
                              Text('${service.rating}',
                                  style: AppFont.bodyLarge(AppColor.black)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Contact:  ',
                                  style: AppFont.bodyLarge(AppColor.gray_dark)),
                              Text('${service.contact}',
                                  style: AppFont.bodyLarge(AppColor.black)),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        Row(
                          children: [
                             GestureDetector(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String userID = prefs.getString('name');
                          StreamChatClient client = await getChatClient();
                          Channel channel = await navigateToChannel(client, userID, service.name);
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StandAloneChannelPage(),
                                    settings: RouteSettings(arguments: ChatArgs(channel: channel, client: client))),);
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_20
                          ),
                          child: Transform.rotate(
                            angle: -math.pi/4,
                            child: Icon(
                            Icons.send_rounded,
                            color: AppColor.white,
                            size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16,),
                            buildButton('Book', service, context),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}