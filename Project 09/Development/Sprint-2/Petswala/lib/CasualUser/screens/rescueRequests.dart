import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/blocs/rescueRequestBloc.dart';
import 'package:petswala/CasualUser/events/rescueRequestEvent.dart';
import 'package:petswala/CasualUser/states/rescueRequestState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/CasualUser/widgets/rescueCard.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'dart:math' as math;

class RescueRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RescueRequestBloc()..add(InitializationEvent()),
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
        }},
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(context),
          backgroundColor: AppColor.white,
          body:Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:16.0),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Live Rescue Requests', style: AppFont.h4Light(AppColor.color_font_dark),),
                    ),
                  ),
                  BlocBuilder<RescueRequestBloc, RescueRequestState>(
                    builder: (context, state) {
                      return state.requests.length < 1 ? Text('loading'): 
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.vertical,
                              itemCount: state.requests.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: 16,);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return RescueCard(rescue:state.requests[index]);
                              },
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          

        ),
      ),
    );
  }
}
