import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:images_picker/images_picker.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/Authentication/login.dart';
import 'package:petswala/CasualUser/blocs/petBloc.dart';
import 'package:petswala/CasualUser/events/addPetEvent.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/homescreen_Casual.dart';
import 'package:petswala/themes/colors.dart';

import '../themes/fonts.dart';

// Add pet 2 is extended screen of Add pet .

class AddPet2 extends StatefulWidget {
  @override
  _AddPet2State createState() => _AddPet2State();
}

class _AddPet2State extends State<AddPet2> {
  var _imageFile;
  var path;
  List<Pet> data = [
    Pet(name: 'dog'),
    Pet(name: 'cat2'),
    Pet(name: 'rabbit'),
    Pet(name: 'fish'),
    Pet(name: 'dog'),
    Pet(name: 'cat2')
  ];

  int current = -1;
  String petname = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPetBloc>(
      create: (BuildContext context) {
        return AddPetBloc();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              icon: Image.asset('assets/back.png'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AddPet()));
              }),
          backgroundColor: Colors.white,
          title: Image.asset('assets/logo2.png', fit: BoxFit.cover),
          centerTitle: true,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusNode currentfocus = FocusScope.of(context);
            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  child: Center(child: new Image.asset('assets/progress3.png')),
                ),
                SizedBox(height: 100),
                Expanded(
                  child: Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            color: Color.fromRGBO(255, 138, 128, 1),
                          ),
                        ),
                        Positioned(
                            top: -80,
                            child: Container(
                              height: 150,
                              width: 150,
                              child: GestureDetector(
                                onTap: () {
                                  //TODO: Upload Image here
                                  showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      context: context,
                                      builder: ((builder) =>
                                          bottom_sheet(context)));
                                },
                                child: path == null
                                    ? new Image.asset('assets/uploadimage.png')
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(path),
                                          fit: BoxFit.fill,
                                        )),
                              ),
                            )),

                        Positioned(
                            top: 100,
                            child: Text('Add Your Pet', style: ptextstyle())),
                        Positioned(
                          top: 140,
                          left: 16,
                          right: -100,
                          child: Container(
                            height: 80,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                        petname = data[index].name;
                                        print(petname);
                                        BlocProvider.of<AddPetBloc>(context)
                                            .add(ChangeCategoryEvent(
                                                category: petname));
                                      });
                                    },
                                    child: ListObject(
                                      name: data[index].name,
                                      selected: current == index,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Positioned(
                            top: 250,
                            left: 40,
                            right: 40,
                            child: Form(
                                key: _formKey,
                                child: Builder(builder: (context) {
                                  return TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: "Enter Pet Name",
                                          labelText: 'Pet',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) => {
                                            BlocProvider.of<AddPetBloc>(context)
                                                .add(ChangeNameEvent(
                                                    name: value))
                                          });
                                }))),
                        Positioned(
                            top: 310,
                            left: 40,
                            right: 40,
                            child: Builder(builder: (context) {
                              return TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 30),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Enter Age",
                                      labelText: 'Age',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onChanged: (value) => {
                                        BlocProvider.of<AddPetBloc>(context)
                                            .add(ChangeAgeEvent(age: value))
                                      });
                            })),

                        Positioned(
                            top: 380,
                            left: 100,
                            right: 100,
                            child: Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  // bloc.submit();

                                  BlocProvider.of<AddPetBloc>(context)
                                      .add(ChangePathEvent(path: path));
                                  BlocProvider.of<AddPetBloc>(context)
                                      .add(SubmitEvent());

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Container(
                                  width: 300,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Color.fromRGBO(85, 68, 119, 1),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'ADD NEW PET',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontFamily: 'Lato',
                                            fontSize: 15,
                                            letterSpacing: 1.25,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))
                        // textField('Breed', "Enter Breed")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottom_sheet(context) {
    return Container(
      // color: AppColor.primary_light,
      height: 90,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: Column(
        children: <Widget>[
          Text('Choose profile picture',
              style: AppFont.bodyLarge(AppColor.accent)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(context);
                    // if (path != null) {
                    //   NetworkHandler nw = NetworkHandler();
                    //   nw.patchImage('add/image', path);
                    // }
                  },
                  icon: Icon(
                    Icons.camera,
                    color: AppColor.primary_dark,
                  ),
                  label: Text(
                    'Camera',
                    style: TextStyle(color: AppColor.primary_dark),
                  )),
              TextButton.icon(
                  onPressed: () async {
                    // TakePhoto(ImageSource.gallery);
                    pickPhoto(context);
                    // if (path != null) {
                    //   NetworkHandler nw = NetworkHandler();
                    //   nw.patchImage('add/image', path);
                    // }
                  },
                  icon: Icon(
                    Icons.image,
                    color: AppColor.primary_dark,
                  ),
                  label: Text('Gallery',
                      style: TextStyle(color: AppColor.primary_dark)))
            ],
          )
        ],
      ),
    );
  }

  void pickPhoto(context) async {
    List<Media> res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.all,
      language: Language.System,
      maxTime: 30,
      // maxSize: 500,
      cropOpt: CropOption(
        // aspectRatio: CropAspectRatio.wh16x9,
        cropType: CropType.circle,
      ),
    );
    print(res);
    if (res != null) {
      print(res.map((e) => e.path).toList());
      setState(() {
        path = res[0].thumbPath;
        // BlocProvider.of<AddPetBloc>(context).add(ChangePathEvent(path: path));
        // nw.patchImage('user/add/image', path);
      });
      // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
      // print(status);
    }
  }

  void takePhoto(context) async {
    List<Media> res = await ImagesPicker.openCamera(
      // pickType: PickType.video,
      pickType: PickType.image,
      quality: 0.8,
      maxSize: 800,
      // cropOpt: CropOption(
      //   aspectRatio: CropAspectRatio.wh16x9,
      // ),
      maxTime: 15,
    );
    print(res);
    if (res != null) {
      print(res[0].path);
      setState(() {
        path = res[0].thumbPath;

        // nw.patchImage('user/add/image', path);
      });
    }
  }
}

class Pet {
  String name;

  Pet({this.name});
}

class ListObject extends StatefulWidget {
  String name;
  bool selected;
  ListObject({this.name, this.selected});

  @override
  _ListObjectState createState() => _ListObjectState();
}

class _ListObjectState extends State<ListObject> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        height: 80,
        width: 80,
        alignment: Alignment.center,
        // height: 100,
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.selected
                    ? Color.fromRGBO(85, 68, 119, 1)
                    : Colors.white),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Image.asset('assets/${widget.name}.png'),
            Text(
              widget.name,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ));
  }
}
