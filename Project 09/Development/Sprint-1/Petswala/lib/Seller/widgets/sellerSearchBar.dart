import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Seller/blocs/ShopBloc.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class SearchBarContainer extends StatelessWidget {
  final event;
  SearchBarContainer({this.event});
  @override
  Widget build(BuildContext context) {
    return SearchBar(event: event);
  }
}

class SearchBar extends StatefulWidget {
  final event;
  SearchBar({this.event});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.all_20,
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        onChanged: (text) {
          // print(text);
          Bloc bloc = BlocProvider.of(context);
          bloc.add(widget.event(text));
        },
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: AppColor.gray_light,
          ),
          contentPadding: EdgeInsets.all(20),
          fillColor: AppColor.gray_transparent,
          filled: true,
          hintText: 'Search',
          hintStyle: AppFont.bodyLarge(AppColor.gray_light),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary),
              borderRadius: AppBorderRadius.all_20),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.gray_transparent),
              borderRadius: AppBorderRadius.all_20),
        ),
      ),
    );
  }
}