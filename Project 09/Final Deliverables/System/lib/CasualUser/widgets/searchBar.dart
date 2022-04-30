import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/userMarketplaceBloc.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class SearchBarContainer extends StatelessWidget {
  final event;
  final String text;
  final bool focus;
  SearchBarContainer({this.event, this.focus, this.text});
  @override
  Widget build(BuildContext context) {
    return SearchBar(event: event, focus:focus, text:text,);
  }
}

class SearchBar extends StatefulWidget {
  final event;
  final String text;
  final bool focus;
  SearchBar({this.event, this.focus:false, this.text:''});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    Bloc bloc = BlocProvider.of<MarketPlaceBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.all_20,
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        onChanged: (text) {
          // print(text);
          bloc.add(widget.event(text));
        },
        autofocus: widget.focus,
        controller: TextEditingController()..text = widget.text == null ? '':widget.text,
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