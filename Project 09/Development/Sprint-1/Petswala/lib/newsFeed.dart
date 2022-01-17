import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petswala/CasualUser/blocs/postBloc.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/states/postState.dart';
import 'Widgets/Post.dart';
import 'Widgets/createPost.dart';
import 'package:petswala/Widgets/Navbars.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(11, 71, 109, 1.0),
        accentColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: newsFeed()));
}

class newsFeed extends StatefulWidget {
  const newsFeed({Key key}) : super(key: key);

  @override
  _newsFeedState createState() => _newsFeedState();
}

class _newsFeedState extends State<newsFeed> {
  @override
  Widget build(BuildContext context) {
    const IconData feed = IconData(0xe25f, fontFamily: 'MaterialIcons');
    int P_C_red = 255;
    int P_C_green = 127;
    int P_C_blue = 127;
    int S_C_red = 14;
    int S_C_green = 103;
    int S_C_blue = 122;
    double phone_width = MediaQuery.of(context).size.width;
    double phone_height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          //centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Image.asset('assets/fa-solid_paw.png'),
              Text('NewsFeed',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color:
                              Color.fromRGBO(P_C_red, P_C_green, P_C_blue, 1.0),
                          fontSize: 30)))
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(context),
        body: Column(
          children: [
            Container(
              //color: Color.fromRGBO(P_C_red, P_C_green, P_C_blue, 1.0),
              decoration: BoxDecoration(
                  //color: Color.fromRGBO(P_C_red, P_C_green, P_C_blue, 1.0),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              width: phone_width,
              //height: phone_height*0.235,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TabBar(
                      indicatorColor:
                          Color.fromRGBO(S_C_red, S_C_green, S_C_blue, 0.5),
                      labelColor:
                          Color.fromRGBO(P_C_red, P_C_green, P_C_blue, 1.0),
                      tabs: [
                        Tab(
                          icon: Icon(feed),
                        ),
                        Tab(
                          icon: Icon(Icons.chat),
                        ),
                        Tab(
                          icon: Icon(Icons.notifications),
                        )
                      ]),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          CreatePost(),
                          SizedBox(
                            height: 50,
                          ),
                          //Post()
                          Container(
                            height: phone_height,
                            width: phone_width * 0.899,
                            child: ListView.builder(
                                itemCount: 100,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Post(),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    Text('Under Maintenance'),
                    Text('Under Maintenance')
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


