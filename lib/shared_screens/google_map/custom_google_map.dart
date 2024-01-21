import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shart/features/user/cart/logic/cart_cubit.dart';
import 'package:shart/features/user/cart/presentation/screen/complete_order.dart';
import 'package:shart/widgets/custom_button.dart';

import '../../core/resources/font_manager.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/routing/routes.dart';
import '../../features/provider/profile/logic/provider_profile_cubit.dart';
import '../../features/user/cart/presentation/widgets/custom_address-user_widget.dart';
import '../../features/user/profile/logic/user_profile_cubit.dart';
import '../../features/user/profile/presentation/address/screens/user_add_address.dart';
import 'address_location_model.dart';

class CustomGoogleMapScreen extends StatefulWidget {
  final double lat;
  final double long;
  final String type;
  const CustomGoogleMapScreen({super.key, required this.lat, required this.long, required this.type});

  @override
  State<CustomGoogleMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<CustomGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? markerPosition; // Initial position (San Francisco)
  @override
  void initState() {
    markerPosition =LatLng(widget.lat, widget.long);
    super.initState();
  }
  TextEditingController searchController = TextEditingController();
   var getLat='';
   var getLong='';
   var getCountry='';
   var getBigCity='';
   var getCity='';
   var getLocality='';
   var getStreet='';
  var titlePosition='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Shart's Map",
        style: TextStyle(
          fontSize: 25.sp,
          fontFamily: FontConstants.lateefFont,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
        )),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (val){
              _searchPlace();
            },
            textInputAction: TextInputAction.search,
            controller: searchController,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: 'Search for a place',
              contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 25),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchPlace();
                },
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onTap: (LatLng position) {
                print('s  lat : ${position.latitude}');
                print('s  long : ${position.longitude}');
                _updateMarker(position);
                getAddressPosition(position);
              },
              initialCameraPosition: CameraPosition(
                target: markerPosition!,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('markerId'),
                  infoWindow: InfoWindow(title: '${titlePosition}'),
                  position: markerPosition!,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    _updateMarker(newPosition);
                  },
                ),
              },
            ),
          ),
          CustomElevatedButton(
              onTap: (){
                if(getCountry.isEmpty){
                  LatLng latng=LatLng(widget.lat, widget.long);
                  setState(() {
                    getAddressPosition(latng);
                  });
                }
                AddressLocationModel addressModel =AddressLocationModel(
                  lat: getLat.isEmpty?widget.lat.toString():getLat ,
                  long: getLong.isEmpty?widget.long.toString():getLong,
                  country: getCountry.isEmpty?'':getCountry,
                  bigCity: getBigCity.isEmpty?'':getBigCity,
                  city: getCity.isEmpty?'':getCity,
                  street: getStreet.isEmpty?'':getStreet,
                  locality: getLocality.isEmpty?'':getLocality,
                );
                if(getCountry.isNotEmpty){
                  if(widget.type=='user'){
                    // UserProfileCubit.get(context).addressLocationModel =addressModel;
                    CartCubit.get(context).addressLocationModel =addressModel;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>CompleteOrder()));
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>UserAddAddressScreen()));


                }else{
                    ProviderProfileCubit.get(context).addressLocationModel =addressModel;
                   NavigationManager.pushReplacement(Routes.providerAddAddress);

                }

                }
              },
              fontSize: 25,
              buttonText: 'Save'),

        ],
      ),
    );
  }
  Future<void> getAddressPosition(LatLng position)async {
    List<Placemark> p = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(p[0].country);
    print(p[0].administrativeArea);
    print(p[0].locality);
    print(p[0].street);
    print(p[0].name);
    print(p[0].subAdministrativeArea);
    setState(() {
      getCountry=p[0].country.toString();
      getBigCity=p[0].administrativeArea.toString();
      getCity=p[0].subAdministrativeArea.toString();
      getLocality=p[0].locality.toString();
      getStreet=p[0].street.toString();
      titlePosition = '${p[0].street}';
    });
  }
  void _updateMarker(LatLng newPosition) {
    setState((){
      getAddressPosition(newPosition);
      getLat=newPosition.latitude.toString();
      getLong=newPosition.longitude.toString();
      markerPosition = newPosition;
    });
  }
  Future<void> _searchPlace() async {
    try {
      List<Location> locations = await locationFromAddress(searchController.text);
      LatLng latLng =LatLng(locations.first.latitude, locations.first.longitude);
      if (locations.isNotEmpty) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
        _updateMarker(latLng);
      } else {
        print('No location found for the provided address.');
      }
    } catch (e) {
      print('Error during geocoding: $e');
    }
  }

}

