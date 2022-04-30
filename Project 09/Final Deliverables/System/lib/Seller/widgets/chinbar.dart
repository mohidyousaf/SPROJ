import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

BottomAppBar bottomAppBar(BuildContext context){
  return BottomAppBar(
    color: Colors.white,
    child: Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('assets/icons/Home_Black.png'))),
          IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('assets/icons/Bag.png'))),
          IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('assets/icons/Chat.png'))),
          IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('assets/icons/Chart.png'))),
          IconButton(onPressed: (){}, icon: ImageIcon(AssetImage('assets/icons/icons8-male-user-16.png')))

        ],
      ),
    ),
  );
}
