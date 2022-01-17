import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/Authentication/addPet.dart';
import 'package:petswala/CasualUser/blocs/petBloc.dart';
import 'package:petswala/CasualUser/events/addPetEvent.dart';
import 'package:petswala/homescreen_Casual.dart';

// Add pet 2 is extended screen of Add pet .

class AddPet2 extends StatefulWidget {
  @override
  _AddPet2State createState() => _AddPet2State();
}

class _AddPet2State extends State<AddPet2> {
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
        body: Column(
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
                        child: GestureDetector(
                          onTap: () => {
                            //TODO: Upload Image here
                          },
                          child: Container(
                              child: new Image.asset('assets/uploadimage.png')),
                        )),
                    Positioned(
                        top: 80,
                        child: Text('Add Your Pet', style: ptextstyle())),
                    Positioned(
                      top: 120,
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
                                    BlocProvider.of<AddPetBloc>(context).add(
                                        ChangeCategoryEvent(category: petname));
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
                        top: 230,
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
                                            .add(ChangeNameEvent(name: value))
                                      });
                            }))),
                    Positioned(
                        top: 290,
                        left: 40,
                        right: 40,
                        child: Builder(builder: (context) {
                          return TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Age",
                                  labelText: 'Age',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onChanged: (value) => {
                                    BlocProvider.of<AddPetBloc>(context)
                                        .add(ChangeAgeEvent(age: value))
                                  });
                        })),

                    Positioned(
                        top: 360,
                        left: 100,
                        right: 100,
                        child: Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              // bloc.submit();
                              BlocProvider.of<AddPetBloc>(context)
                                  .add(SubmitEvent());
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
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
                                        color: Color.fromRGBO(255, 255, 255, 1),
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
    );
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
