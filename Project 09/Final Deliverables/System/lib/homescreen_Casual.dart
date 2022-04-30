import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
//         accentColor: Colors.white,
//         textTheme: GoogleFonts.latoTextTheme(),
//       ),
//       home: HomeScreen()
//   ));
// }

class HomeScreen extends StatelessWidget {
  final categoryList = CategoryData().categoryList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar(context),
        body: GestureDetector(
           onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild.unfocus();
              }},
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
              Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:70.0),
                  child: Logo(color:AppColor.primary),
        
                ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Builder(builder: (context) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 3,
                                  onChanged: (text) {
                                    if (text.length >= 3){
                                      Navigator.pushNamed(context, '/adoption', arguments: text);
                                      
                                    }
                                    // print(text);
                                    // BlocProvider.of<PostBloc>(context).add(ChangeNewPostTextEvent(text:text));
                                  },
                                  decoration: InputDecoration(   
                                    contentPadding: EdgeInsets.all(20),
                                    fillColor: AppColor.gray_transparent,
                                    filled: true,
                                    hintText: 'Adopt a new friend',
                                    hintStyle: AppFont.bodyLarge(AppColor.gray_light),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: AppColor.primary),
                                        borderRadius: AppBorderRadius.all_20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: AppColor.gray_transparent),
                                        borderRadius: AppBorderRadius.all_20),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left:16),
                              child: GestureDetector(
                                onTap: () async{
                                  // BlocProvider.of<PostBloc>(context).add(AddPostEvent());
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                    currentFocus.focusedChild.unfocus();                                           
                                  }
                                   print('dsds');
                                   StreamChatClient client = await getChatClient();
                                    Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ChatNavigator(client: client),
                                              settings: RouteSettings(name: '/')),);  },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.primary, 
                                    borderRadius: AppBorderRadius.all_15),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(16,15.5,16,15.5),
                                    child: Transform.rotate(angle: -math.pi/4,child: Icon(Icons.send_rounded, color: AppColor.white, size: 30,)),
                                  )),
                              ),
                            )
                            ],
                          );
                          }),
                      ),
                      
            // Container(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
            //               child: Transform.rotate(
            //                 angle: -math.pi / 4,
            //                 child: Icon(
            //                   Icons.pets_outlined,
            //                   size: 20,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //             Text(
            //               'Petswala',
            //               style: GoogleFonts.getFont('Bubblegum Sans',
            //                   fontSize: 20,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.w200),
            //               textAlign: TextAlign.left,
            //             ),
            //           ],
            //         ),
            //       ),
                  
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(30, 5, 30, 20),
            //         child: TextField(
            //           onChanged: (text) {
            //             Navigator.pushNamed(context, '/search');
            //           },
            //           decoration: InputDecoration(
            //             suffixIcon: Icon(Icons.search),
            //             contentPadding: EdgeInsets.fromLTRB(20, 3, 20, 3),
            //             fillColor: Colors.white,
            //             filled: true,
            //             hintText: 'Search',
            //             hintStyle: GoogleFonts.lato(
            //                 textStyle: TextStyle(color: Colors.grey)),
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.all(
            //               const Radius.circular(16.0),
            //             )),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   height: 250,
            //   decoration: BoxDecoration(
            //       color: Color.fromRGBO(255, 137, 137, 1),
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(20),
            //           bottomRight: Radius.circular(20))),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
                    //   child: Text(
                    //     'Find a Service',
                    //     style: GoogleFonts.getFont('Gothic A1',
                    //         fontSize: 20,
                    //         color: Colors.black54,
                    //         fontWeight: FontWeight.w500),
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(249, 169, 111, 1),
                            borderRadius: AppBorderRadius.all_20,),
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/serviceHome');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    children: [Container(
                                      height:75,
                                      width:75,
                                      decoration: BoxDecoration(
                                        borderRadius: AppBorderRadius.all_50
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.asset('assets/icons/pet_services.png')),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Find a Service',
                                        style: GoogleFonts.getFont('Gothic A1',
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    ]),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(10,5,10,20),
                            //   child: Divider(height: 3, thickness: 2,color: Colors.black12,),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 186, 156, 1),
                            borderRadius: AppBorderRadius.all_20,),
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 30, 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/feed');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Trending Posts',
                                      style: GoogleFonts.getFont('Gothic A1',
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(10,5,10,20),
                            //   child: Divider(height: 3, thickness: 2,color: Colors.black12,),
                            // ),
                            Center(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.white70
                                        // color: Color.fromRGBO(41, 66, 95, 1)
                                        ),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/feed');
                                        },
                                        child: Image.asset('assets/collage.png'))))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  Category category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, category.link);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 149, 149, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Image.asset(
                category.imLink,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              category.name,
              style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  String imLink = '';
  String name = '';
  String link = '/home';
  Category({this.imLink, this.name, this.link});
}
class CategoryData {
  List<Category> categoryList = [
    Category(
        imLink: 'assets/stethoscope.png', name: 'Vet', link: '/maintenance'),
    Category(
        imLink: 'assets/daycare-center.png',
        name: 'Daycare',
        link: '/maintenance'),
    Category(
        imLink: 'assets/dog-training.png',
        name: 'Training',
        link: '/maintenance'),
    Category(
        imLink: 'assets/dog_walking.png',
        name: 'Walking',
        link: '/maintenance'),
    Category(
        imLink: 'assets/grooming.png', name: 'Grooming', link: '/maintenance'),
  ];
}

// Container(
//   height: 180,
//   child: ListView.separated(
//     scrollDirection: Axis.horizontal,
//     itemCount: categoryList.length,
//     padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
//     itemBuilder: (context, index) {
//       return CategoryCard(category: categoryList[index]);
//     },
//     separatorBuilder: (context, int) {
//       return SizedBox(width: 10);
//     },
//   ),
// ),

// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Text(
//     'Adopt a new friend',
//     style: GoogleFonts.getFont('Gothic A1',
//         fontSize: 36,
//         color: Colors.white,
//         fontWeight: FontWeight.w200),
//     textAlign: TextAlign.left,
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.only(bottom: 5),
//   child: Text(
//     'give a new home to a pet',
//     style: GoogleFonts.lato(
//         fontSize: 18,
//         color: Colors.white,
//         fontWeight: FontWeight.w200),
//     textAlign: TextAlign.left,
//   ),
// ),