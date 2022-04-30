
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class RescueMenu extends StatelessWidget {
  const RescueMenu({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(context),
      body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
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
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Logo(color: AppColor.primary)),
                  ],
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/rescue');
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: AppBorderRadius.all_20,
                            ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'New\nRescue',
                                  textAlign: TextAlign.center,
                                  style: AppFont.h5(AppColor.white),
                                ),
                              ),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed('/rescueRequests');
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: AppBorderRadius.all_20,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'View\nRequests',
                                textAlign: TextAlign.center,
                                style: AppFont.h5(AppColor.white),
                              ),
                            )),
                          ),
                      )
                    ],
                  ),
                )
                
              ],
            ),
          ),
    );
  }
}