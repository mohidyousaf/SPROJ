import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petswala/CasualUser/blocs/rescueBloc.dart';
import 'package:petswala/CasualUser/events/rescueEvent.dart';
import 'package:petswala/CasualUser/states/rescueState.dart';
import 'package:petswala/CasualUser/widgets/navBars.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';

class RescueHome extends StatelessWidget {
  const RescueHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RescueBloc(),
      child: RescuePage(),
    );
  }
}

class RescuePage extends StatefulWidget {
  const RescuePage({Key key}) : super(key: key);

  @override
  _RescuePageState createState() => _RescuePageState();
}

class _RescuePageState extends State<RescuePage> {
  bool x = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RescueBloc, RescueState>(
      listener: (context, state) {
        if (state.requestSubmitted) {
          Navigator.of(context).pushNamed('/home');
        }
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavBar(context),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild.unfocus();
              }
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMapScreen(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: x ? 375 : 90,
                    decoration: BoxDecoration(
                        color: AppColor.secondary_extraLight,
                        borderRadius: AppBorderRadius.all_30),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: x
                          ? SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RescueInput(
                                      hintText: 'contact no',
                                      func: RescueFuncs.changeContact),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  RescueInput(
                                      hintText: 'animal type',
                                      func: RescueFuncs.changePetType),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  RescueInput(
                                      numLines: 3,
                                      hintText: 'description',
                                      func: RescueFuncs.changeDescription),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<RescueBloc>(context)
                                            .add(PostRescueEvent());
                                      },
                                      child: Container(
                                        width: 350,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                AppBorderRadius.all_20,
                                            color: AppColor.primary),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 20),
                                        child: Center(
                                          child: BlocBuilder<RescueBloc,RescueState>(
                                            builder: (context, state) {
                                              return state != null ? 
                                              state.loading ?                                              
                                                  CircularProgressIndicator()
                                                  : Text('Post Rescue Request',
                                                      style: AppFont.button(
                                                          AppColor.white))
                                              : Text('Post Rescue Request',
                                                  style: AppFont.button(
                                                      AppColor.white));
                                            
                                        })),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  RescueBloc bloc =
                                      BlocProvider.of<RescueBloc>(context);
                                  GoogleMapController controller =
                                      bloc.state.controller;
                                  controller.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(
                                                  bloc.state.pos.latitude -
                                                      0.05,
                                                  bloc.state.pos.longitude),
                                              zoom: 12)));
                                  return x = x ? false : true;
                                  // Bloc bloc = BlocProvider.of<ProductBloc>(context);
                                  // bloc.add(AddProductEvent());
                                  // shopBloc.add(RefreshListEvent());
                                  // Navigator.pop(context);
                                }),
                                child: Container(
                                  width: 350,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: AppBorderRadius.all_20,
                                      color: AppColor.primary),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 20),
                                  child: Center(
                                    child: Text('Confirm Location',
                                        style: AppFont.button(AppColor.white)),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class GoogleMapScreen extends StatefulWidget {
  // GoogleMapController googleMapController;
  GoogleMapScreen({Key key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static const _initialPosition =
      CameraPosition(target: LatLng(37.77392, -122.431297), zoom: 11);

  Marker origin;
  Marker destination;

  @override
  void dispose() {
    super.dispose();
  }

  Location _location = Location();
  LocationData l;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        BlocProvider.of<RescueBloc>(context).add(MapInitializationEvent(
            controller: controller,
            pos: LatLng(_initialPosition.target.latitude,
                _initialPosition.target.longitude)));
      },
      onLongPress: _addMarker,
      markers: {
        if (origin != null) origin,
      },
    );
  }

  void _addMarker(LatLng pos) async {
    {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      print(pos.latitude);
      Image i = Image.asset('assets/transparent_paw.png');
      BitmapDescriptor icon =
          await getMarkerIcon('assets/transparent_paw.png', Size(150.0, 150.0));
      setState(() {
        origin = Marker(
            draggable: true,
            markerId: MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Rescue Location'),
            icon: icon,
            position: pos,
            onDragEnd: (pos) {
              _addMarker(pos);
            });
        BlocProvider.of<RescueBloc>(context)
            .add(ChangeLocationEvent(lat: pos.latitude, long: pos.longitude));

        // Reset info
      });
    }
  }

  Future getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData current = await _location.getLocation();
    setState(() {
      // widget.googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(current.latitude, current.longitude), zoom: 13)));
      origin = Marker(
          draggable: true,
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Rescue Location'),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(current.latitude, current.longitude),
          onDragEnd: (pos) {
            _addMarker(pos);
          });
      BlocProvider.of<RescueBloc>(context).add(
          ChangeLocationEvent(lat: current.latitude, long: current.longitude));
    });
  }
}

class RescueInput extends StatelessWidget {
  final Function func;
  final hintText;
  final numLines;
  const RescueInput({Key key, this.hintText, this.func, this.numLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RescueBloc, RescueState>(
      builder: (context, state) {
        return CustomTextFormField(
          numLines: numLines,
          func: func,
          hintText: hintText,
          isValid: state,
        );
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key key, this.func, this.hintText, this.isValid, this.numLines})
      : super(key: key);

  final Function func;
  final hintText;
  final isValid;
  final numLines;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: TextFormField(
        onChanged: (text) {
          // print(isValid.passIsValid);
          func(context, text);
        },
        minLines: numLines == null ? 1 : numLines,
        maxLines: numLines == null ? 1 : 4,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          fillColor: AppColor.gray_transparent,
          filled: true,
          hintText: hintText,
          // errorText: isValid.passIsValid ? null : 'Wrong Input',
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

class RescueFuncs {
  static void changeLocation(context, lat, long) {
    BlocProvider.of<RescueBloc>(context)
        .add(ChangeLocationEvent(lat: lat, long: long));
  }

  static void changePetType(context, type) {
    BlocProvider.of<RescueBloc>(context).add(ChangePetEvent(petType: type));
  }

  static void changeContact(context, text) {
    BlocProvider.of<RescueBloc>(context).add(ChangeContactEvent(contact: text));
  }

  static void changeDescription(context, text) {
    BlocProvider.of<RescueBloc>(context)
        .add(ChangeDescriptionEvent(text: text));
  }
}

Future<BitmapDescriptor> getMarkerIcon(String imagePath, Size size) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final Radius radius = Radius.circular(size.width / 2);

  final Paint tagPaint = Paint()..color = Colors.blue;
  final double tagWidth = 40.0;

  final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
  final double shadowWidth = 15.0;

  final Paint borderPaint = Paint()..color = Colors.white;
  final double borderWidth = 3.0;

  final double imageOffset = shadowWidth + borderWidth;

  // Add shadow circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowPaint);

  // Add border circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(shadowWidth, shadowWidth, size.width - (shadowWidth * 2),
            size.height - (shadowWidth * 2)),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      borderPaint);

  // Add tag circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      tagPaint);

  // Add tag text
  TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
  textPainter.text = TextSpan(
    text: '1',
    style: TextStyle(fontSize: 20.0, color: Colors.white),
  );

  textPainter.layout();
  textPainter.paint(
      canvas,
      Offset(size.width - tagWidth / 2 - textPainter.width / 2,
          tagWidth / 2 - textPainter.height / 2));

  // Oval for the image
  Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
      size.width - (imageOffset * 2), size.height - (imageOffset * 2));

  // Add path for oval image
  canvas.clipPath(Path()..addOval(oval));

  // Add image
  // ui.Image image = await getImageFromPath(imagePath); // Alternatively use your own method to get the image
  // paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

  // Convert canvas to image
  final ui.Image markerAsImage = await pictureRecorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());

  // // Convert image to bytes
  final ByteData byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List uint8List = byteData.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(uint8List);
}

Future<ui.Image> getImageFromPath(String imagePath) async {
  File imageFile = File(imagePath);

  var imageBytes = imageFile.readAsBytesSync();

  final Completer<ui.Image> completer = new Completer();

  ui.decodeImageFromList(imageBytes, (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}
