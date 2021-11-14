import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({
    Key key

  }) : super(key: key);

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
      width: phone_width*0.899,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ayan Tabassum Saeed'),
                    Text(' 6h')
                  ],
                ),
              )

            ],
          ),
          SizedBox(height: 20,),
          Image.asset('assets/cat.png'),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
