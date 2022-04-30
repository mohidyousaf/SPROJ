import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/events/adoption_event.dart';
import 'package:petswala/CasualUser/models/petInfo.dart';
import 'package:petswala/CasualUser/screens/petPage.dart';
import 'package:petswala/CasualUser/states/adoption_state.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/CasualUser/blocs/adoption_bloc.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'package:bottom_drawer/bottom_drawer.dart';

class AdoptionRouter extends StatelessWidget {
  const AdoptionRouter({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final RouteSettings passedSettings = ModalRoute.of(context).settings;
    return BlocProvider(
      create: (context) => AdoptionBloc()..add(InitializeListEvent()),
      child: Navigator(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/':
              page = Adoption();
              break;
            case '/petPage':
              page = PetPage();
              break;
          }
          return MaterialPageRoute(
              builder: (context) => page,
              settings:
                  settings.arguments != null ? settings : passedSettings);
        },
      ),
    );
  }
}

class Adoption extends StatefulWidget {
  const Adoption({Key key}) : super(key: key);

  @override
  State<Adoption> createState() => _AdoptionState();
}

class _AdoptionState extends State<Adoption> {
  ScrollController controller;
  BottomDrawerController drawerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();
    drawerController = BottomDrawerController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = ModalRoute.of(context).settings.arguments;
    bool focus = false;
    if (text != null) {
      focus = true;
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
        endDrawer: FilterDrawer(controller: drawerController),
        bottomNavigationBar: HideableNavBar(
            controller: controller, child: BottomNavBar(context)),
        appBar: AppBar(
          title: Logo(color: AppColor.primary),
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/home'),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: AppBorderRadius.all_25),
                  child: Icon(
                    CupertinoIcons.back,
                    color: AppColor.white,
                    size: 30,
                  )),
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          elevation: 0,
        ),
        body: Container(
          color: Color.fromRGBO(250, 250, 250, 1),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SearchBarContainer(
                        text: text == null ? "Find a new friend" : text,
                        focus: focus,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: GestureDetector(
                      onTap: () {
                        drawerController.open();
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => FilterDrawer());
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: AppBorderRadius.all_20),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: CategoryChips(),
              ),
              BlocBuilder<AdoptionBloc, AdoptionState>(
                builder: (context, state) {
                  return state.loading ? Padding(
                    padding: const EdgeInsets.symmetric(vertical:16.0),
                    child: CircularProgressIndicator(color: AppColor.primary,),
                  )
                  :Expanded(
                    child: ListView.separated(
                        controller: controller,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) => PetCard(pet:state.displayedPets[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 16,
                            ),
                        itemCount: state.displayedPets.length),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarContainer extends StatelessWidget {
  final event;
  final String text;
  final bool focus;
  SearchBarContainer({this.event, this.focus, this.text});
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      event: event,
      focus: focus,
      text: text,
    );
  }
}

class SearchBar extends StatefulWidget {
  final event;
  final String text;
  final bool focus;
  SearchBar({this.event, this.focus: false, this.text: ''});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    controller.text = widget.text == null ? '':widget.text;
  }
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
          // bloc.add(widget.event(text));
        },
        autofocus: widget.focus,
        controller: controller,
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

class PetCard extends StatelessWidget {
  final PetInfo pet;
  const PetCard({Key key, this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pet.petId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/petPage', arguments: pet.petId);
        },
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColor.white, borderRadius: AppBorderRadius.all_25),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 100,
                            width: 100,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: AppBorderRadius.all_20),
                            child: pet.category == 'Cat' ? Image.asset('assets/cat.png'):
                            Image.asset('assets/images.jpg', fit: BoxFit.fitHeight,)
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet.name,
                              style: AppFont.h5(AppColor.color_font_dark),
                            ),
                            Text(
                              pet.category,
                              style: AppFont.bodySmall(AppColor.gray_light),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: AppBorderRadius.all_20,
                    ),
                    child: Icon(CupertinoIcons.forward),
                  ),
                ])),
      ),
    );
  }
}

class CategoryChips extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Color activeTextColor;
  final Color activeColor;
  final event;
  final List categories = ['All', 'Dog', 'Cat', 'Rabbit', 'Bird'];

  CategoryChips(
      {this.text,
      this.activeColor: AppColor.primary,
      this.activeTextColor: AppColor.white,
      this.color: AppColor.gray_transparent,
      this.textColor: AppColor.black,
      this.event});

  @override
  _CategoryChipsState createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) => categoryChip(index),
        separatorBuilder: (context, int) => SizedBox(width: 16),
      ),
    );
  }

  Widget categoryChip(int index) {
    AdoptionBloc bloc = BlocProvider.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          print('dsdssssssss');
          selectedIndex = index;
          bloc.add(ChangeSelectionEvent(category: widget.categories[index]));
        });
        print(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.all_20,
          color: selectedIndex == index ? widget.activeColor : widget.color,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(widget.categories[index],
            textAlign: TextAlign.center,
            style: AppFont.bodyLarge(selectedIndex == index
                ? widget.activeTextColor
                : widget.textColor)),
      ),
    );
  }
}

class FilterDrawer extends StatelessWidget {
  final BottomDrawerController controller;
  const FilterDrawer({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: AppColor.primary,
    );
  }
}
