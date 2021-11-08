import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,40,8,20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,5,5),
                        child: Transform.rotate(
                          angle: -math.pi/4,
                          child: Icon(Icons.pets_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text('Petswala',
                        style:GoogleFonts.getFont('Bubblegum Sans',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left
                        ,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Adopt a new friend',
                    style:GoogleFonts.getFont('Gothic A1',
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w200
                    ),
                    textAlign: TextAlign.left
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text('give a new home to a pet',
                    style:GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w200
                    ),
                    textAlign: TextAlign.left
                    ,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,5,30,20),
                  child: TextField(
                    onChanged: (text){
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.fromLTRB(20,3,20,3),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(16.0),)
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 137, 137, 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
                    child: Text('Find a Service',
                      style:GoogleFonts.getFont('Gothic A1',
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left
                      ,),
                  ),
                  Container(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                      itemBuilder: (context, int) {
                        return Card();
                      },
                      separatorBuilder: (context, int) {
                        return SizedBox(width: 10);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 186, 156, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,30,20),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trending Posts',
                                  style:GoogleFonts.getFont('Gothic A1',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  ),
                                  textAlign: TextAlign.left
                                  ,),
                                Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(10,5,10,20),
                        //   child: Divider(height: 3, thickness: 2,color: Colors.black12,),
                        // ),
                        Center(child:
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white70
                            // color: Color.fromRGBO(41, 66, 95, 1)
                          ),
                            child: GestureDetector(
                                onTap: (){
                                    print('object');
                                },
                                child: Image.asset('assets/collage.png'))))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Image.asset('assets/home.png',
                             height: 30,
                              width: 30,),
                        // Text('Home', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/reportsHome');
                    }
                ),
                TextButton(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Image.asset('assets/marketplace.png',
                          height: 25,
                          width: 25,),
                      ),
                        // Text('Shop', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/reportsHome');
                    }
                ),
                TextButton(
                    child:Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white12
                      ),
                      child: Image.asset('assets/emergency-call.png',
                      height: 35,
                      width: 35,),
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/reportsHome');
                    }
                ),
                TextButton(
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Icon(Icons.chat_outlined,
                              color: Color.fromRGBO(84, 84, 84, .6),
                              size: 28,),
                        // Text('Edit', style:  GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0)))),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/reportsHome');
                    }
                ),
                TextButton(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          Icons.person_outline_outlined,
                          color: Color.fromRGBO(84, 84, 84, .6),
                          size: 32
                        ),
                      // Text('Profile', style:
                      // GoogleFonts.lato(textStyle: TextStyle(color: Color.fromRGBO(11, 71, 109, 1.0))),
                      // ),
                    ],
                  ),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/inventory');
                  },
                ),
              ]
          )
         ]),
    );
  }
}

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 149, 149, 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
                Image.asset('assets/grooming.png',
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                  ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('Grooming',
            style:GoogleFonts.lato(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.normal
            ),
            textAlign: TextAlign.left
            ,),
        ),
      ],
    );
  }
}
