import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:petswala/themes/branding.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

// import 'dart:math' as math;

class ServicesHome extends StatelessWidget {
  const ServicesHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryList = CategoryData().categoryList;
    final List<ServiceInfo> service = [
      ServiceInfo(
          name: 'rehan',
          rate: 120,
          description:
              "Dedicated veterinarian seeking positions in the Seattle area. Skilled in treating animals, working in high-pressure environments and problem-solving. Passionate about educating pet owners on their pets' health and well-being, as well as advocating for animal rights.",
          type: 'Vet',
          imLink: 'assets/5506680.jpg',
          contact: '03462177528',
          rating: 2),
      ServiceInfo(
          name: 'Mohid',
          rate: 250,
          description:
              "We are the best veterinary in the Seattle area. Skilled in treating animals, working in high-pressure environments and problem-solving. Passionate about educating pet owners on their pets' health and well-being, as well as advocating for animal rights.",
          type: 'Vet',
          imLink: 'assets/5506680.jpg',
          contact: '03203543535',
          rating: 4),
      ServiceInfo(
          name: 'Shiffa',
          rate: 150,
          description:
              "Finding the best in the place? Skilled in treating animals, working in high-pressure environments and problem-solving. Passionate about educating pet owners on their pets' health and well-being, as well as advocating for animal rights.",
          type: 'Vet',
          imLink: 'assets/5506680.jpg',
          contact: '03364213881',
          rating: 1)
    ];
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(context),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: AppColor.primary,
                                    borderRadius: AppBorderRadius.all_25),
                                child: Center(
                                    child: Icon(
                                  CupertinoIcons.back,
                                  color: AppColor.white,
                                  size: 30,
                                ))),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: Logo(color: AppColor.primary)),
                        ],
                      ),
                    ),
                  ),
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
                                // BlocProvider.of<PostBloc>(context).add(ChangeNewPostTextEvent(text:text));
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                fillColor: AppColor.gray_transparent,
                                filled: true,
                                hintText: 'Search services',
                                hintStyle:
                                    AppFont.bodyLarge(AppColor.gray_light),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.primary),
                                    borderRadius: AppBorderRadius.all_20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.gray_transparent),
                                    borderRadius: AppBorderRadius.all_20),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: InkWell(
                              onTap: () {
                                // BlocProvider.of<PostBloc>(context).add(AddPostEvent());
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus &&
                                    currentFocus.focusedChild != null) {
                                  currentFocus.focusedChild.unfocus();
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: AppBorderRadius.all_15),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 19.5, 19, 19.5),
                                    child: Icon(
                                      Icons.search_rounded,
                                      color: AppColor.white,
                                    ),
                                  )),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  Container(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
                      itemBuilder: (context, index) {
                        return CategoryCard(category: categoryList[index]);
                      },
                      separatorBuilder: (context, int) {
                        return SizedBox(width: 10);
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Popular services',
                            style: AppFont.h4Light(AppColor.color_font_dark)),
                      )),
                  Container(
                    height: 385,
                    padding: EdgeInsets.all(16),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ServiceCard(
                              service: service[index],
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 16,
                            ),
                        itemCount: 3),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, category.link);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Image.asset(
                category.imLink,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              category.name,
              style: AppFont.bodySmall(AppColor.black),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  String imLink = '';
  String name = '';
  String link = '/home';
  Color color;
  Category(
      {this.imLink, this.name, this.link, this.color: AppColor.primary_light});
}

class CategoryData {
  List<Category> categoryList = [
    Category(
        imLink: 'assets/stethoscope.png',
        name: 'Vet',
        link: '/maintenance',
        color: AppColor.primary),
    Category(
        imLink: 'assets/daycare-center.png',
        name: 'Daycare',
        link: '/maintenance'),
    Category(
        imLink: 'assets/dog-training.png',
        name: 'Training',
        link: '/maintenance'),
    Category(
        imLink: 'assets/dog_walking.png',
        name: 'Walking',
        link: '/maintenance'),
    Category(
        imLink: 'assets/grooming.png', name: 'Grooming', link: '/maintenance'),
  ];
}

class ServiceCard extends StatelessWidget {
  final ServiceInfo service;
  const ServiceCard({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/servicePage', arguments: service);
      },
      child: Container(
        width: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.secondary_light,
            borderRadius: AppBorderRadius.all_25),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: AppBorderRadius.all_25),
              child: Image.asset(service.imLink),
              height: 235,
              width: 250,
              clipBehavior: Clip.hardEdge,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.name,
                          style: AppFont.bodyLarge(AppColor.black)),
                      Text(service.type,
                          style: AppFont.caption(AppColor.gray_dark)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColor.yellow,
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${service.rating}',
                          style: AppFont.caption(AppColor.yellow)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs ${service.rate}/hr',
                      style: AppFont.h5(AppColor.primary)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceInfo {
  final String name;
  final String description;
  final String type;
  final double rate;
  final String imLink;
  final double rating;
  final String contact;

  ServiceInfo(
      {this.name,
      this.description,
      this.type,
      this.rate,
      this.imLink,
      this.rating,
      this.contact});
}
