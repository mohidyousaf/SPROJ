import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
