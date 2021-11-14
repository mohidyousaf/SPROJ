
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    int P_C_red = 255;
    int P_C_green = 127;
    int P_C_blue = 127;
    int S_C_red = 14;
    int S_C_green = 103;
    int S_C_blue = 122;
    double phone_width = MediaQuery.of(context).size.width;
    double phone_height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: phone_width*0.8,
            height: 38,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'Whats on your mind',
              ),
              onTap: (){},
            ),
          )
        ],
      ),
    );
  }
}
