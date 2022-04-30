import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petswala/CasualUser/blocs/rescueRequestBloc.dart';
import 'package:petswala/CasualUser/models/rescueInfo.dart';
import 'package:petswala/CasualUser/states/rescueRequestState.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:petswala/themes/spacingAndBorders.dart';

class RescueCard extends StatelessWidget {
  final RescueInfo rescue;
  const RescueCard({Key key, this.rescue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RescueRequestBloc, RescueRequestState>(
      builder: (context, state) {
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
                  title: rescue.petType==null ? Text(' '):Text(rescue.petType),
                  subtitle: rescue.name==null ? Text(' '):Text('${rescue.name}, 0m away'),
                  // trailing: post.time==null ? Text(' '):Text('${DateTime.now().difference(post.time).inDays} days ago'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.all_20
                  ),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMapScreen(location:rescue.pos)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align( alignment: Alignment.centerLeft,child: rescue.description==null ? Text('Description'):Text('Description: ${rescue.description}')),
              ),
              GestureDetector(
                onTap: (){
                  
                },
                child: Container(
                  width: 350,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.all_20,
                      color: AppColor.primary),
                  padding: EdgeInsets.symmetric(
                      horizontal: 0, vertical: 20),
                  child: Center(
                    child: Text('Accept Request',
                        style: AppFont.button(AppColor.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      },
    );
  }
}

class GoogleMapScreen extends StatefulWidget {
  final LatLng location;
  GoogleMapScreen({Key key, this.location}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  Marker origin;
  GoogleMapController googleMapController;


  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target:widget.location, zoom: 13),
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      onMapCreated: (controller) {
        googleMapController = controller;
      },
      markers: {
        Marker(
            draggable: true,
            markerId: MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Rescue Location'),
            icon: BitmapDescriptor.defaultMarker,
            position: widget.location)
      },
    );
  }
}
