import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/postBloc.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/models/postInfo.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';


class PostCard extends StatelessWidget {
    final PostInfo post;
    final event;
    final int index;
    PostCard({this.post, this.event, this.index});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: AppColor.secondary_extraLight,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.secondary_light,
                  borderRadius: AppBorderRadius.all_15),
                child: ListTile(
                  leading: Container(
                    height: 50,
                    width: 50, decoration: BoxDecoration(borderRadius: AppBorderRadius.all_50),
                    child: Center(child: Icon(Icons.account_circle, size: 50,)),),
                  title: post.posterName==null ? Text(' '):Text(post.posterName),
                  subtitle: post.posterType==null ? Text(' '):Text(post.posterType),
                  trailing: post.time==null ? Text(' '):Text('${DateTime.now().difference(post.time).inDays} days ago'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align( alignment: Alignment.centerLeft,child: post.posterName==null ? Text(' '):Text(post.text)),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Bloc bloc = BlocProvider.of<PostBloc>(context);
                      bloc.add(LikePostEvent(index: index));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:post.liked ?Icon(Icons.favorite_rounded, 
                      color: AppColor.primary,
                      size: 25,):
                      Icon(
                      Icons.favorite_outline_rounded, 
                      color: AppColor.primary,
                      size: 25,)
                    ),
                  ),
                  SizedBox(width: 2,),
                  post.likes==null ? 
                  Text('0 likes'):
                  Text('${post.likes} likes', 
                    style: AppFont.overLine(AppColor.primary),
                  ),
                ],
              )


            ],
          ),
        ),
      );
    }
}