import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'package:petswala/CasualUser/blocs/postBloc.dart';
import 'package:petswala/CasualUser/events/postEvent.dart';
import 'package:petswala/CasualUser/states/postState.dart';
import 'package:petswala/bloc/pet_bloc.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:auto_size_text_field/auto_size_text_field.dart';

import 'dart:math' as math;

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(InitializationEvent()),
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
        }},
        child: Scaffold(
          body:SingleChildScrollView(
            child: Column(
              children: [
                Logo(color:AppColor.primary),
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
                              // print(text);
                              BlocProvider.of<PostBloc>(context).add(ChangeNewPostTextEvent(text:text));
                            },
                            decoration: InputDecoration(   
                              contentPadding: EdgeInsets.all(20),
                              fillColor: AppColor.gray_transparent,
                              filled: true,
                              hintText: 'New Post',
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
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<PostBloc>(context).add(AddPostEvent());
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                              currentFocus.focusedChild.unfocus();                                           
                            }},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.primary, 
                              borderRadius: AppBorderRadius.all_15),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20,19.5,19,19.5),
                              child: Transform.rotate(
                                angle: -math.pi/5,
                                child: Icon(Icons.send, color: AppColor.white,)),
                            )),
                        ),
                      )
                      ],
                    );
                    }),
                ),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    return state.posts.length < 1 ? Text('no posts'): ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.vertical,
                          itemCount: state.posts.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 16,);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<PostBloc>(context).add(LikePostEvent(index: index));                                           
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.primary, 
                                        borderRadius: AppBorderRadius.all_15),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(20,19.5,19,19.5),
                                        child: state.posts[index].liked ? 
                                        Icon(Icons.favorite, color: AppColor.white,):
                                        Icon(Icons.favorite_border_rounded, color: AppColor.white,),
                                      )),
                                  ),
                                ),
                                Flexible(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text('${state.posts[index].likes}'),
                                )),
                                Flexible(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text(state.posts[index].text),
                                )),
                                

                              ],
                            );
                          },
                        );
                  },
                ),
              ],
            ),
          ),
          

        ),
      ),
    );
  }
}
