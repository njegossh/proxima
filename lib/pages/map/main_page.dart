import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/locator.dart';
import 'package:proxima/pages/map/components/InstructorsBottomSheet.dart';

final User exampleUser1 = User(
  id: 'cc-5679-zz',
  locationX: -22.302962,
  locationY: -49.061220,
  name: 'Goran',
  surname: 'Edman',
  interests: ['Music', 'Singing'],
);

final List<User> exampleInstructors = [
  User(
    id: '34560-c4',
    locationX: -22.304803,
    locationY: -49.062652,
    name: 'Howie',
    surname: 'Simon',
    interests: ['Music', 'Singing', 'Guitar'],
  ),
  User(
    id: '65430-c55',
    locationX: -22.295501,
    locationY: -49.055607,
    name: 'Fredrik',
    surname: 'Akesson',
    interests: ['Music', 'Singing', 'Guitar'],
  ),
];

class MapMainPage extends StatefulWidget {
  const MapMainPage({super.key});

  @override
  State<MapMainPage> createState() => _MapMainPageState();
}

class _MapMainPageState extends State<MapMainPage> {
  final MapController _mapController = MapController();
  double _radius = 1500;
  bool _instructorsSheetVisible = false;

  LatLng userLocation = LatLng(exampleUser1.locationX, exampleUser1.locationY);

  List<User> getInstructorsWithinRadius() {
    final Distance distance = Distance();
    return exampleInstructors
        .where(
          (instructor) =>
              distance.as(
                LengthUnit.Meter,
                userLocation,
                LatLng(instructor.locationX, instructor.locationY),
              ) <=
              _radius,
        )
        .toList();
  }

  void getCurrentLocation() async {
    Position position = await getCurrentPosition();
    final newLocation = LatLng(position.latitude, position.longitude);
    setState(() {
      userLocation = newLocation;
    });
    _mapController.move(newLocation, 13);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
            onPressed: getCurrentLocation,
            icon: Icon(Icons.my_location),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(initialCenter: userLocation, initialZoom: 13),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation,
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.person_pin_circle,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    ...exampleInstructors.map(
                      (instructor) => Marker(
                        point: LatLng(
                          instructor.locationX,
                          instructor.locationY,
                        ),
                        width: 30,
                        height: 30,
                        child: Icon(Icons.person, color: Colors.purple),
                      ),
                    ),
                  ],
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: userLocation,
                      radius: _radius,
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blue,
                      useRadiusInMeter: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Radius ${_radius.toInt()} meters'),
                    Slider(
                      min: 1000,
                      max: 100000,
                      divisions: 50,
                      value: _radius,
                      onChanged: (value) {
                        setState(() => _radius = value);
                      },
                      onChangeEnd: (value) {
                        final updated = getInstructorsWithinRadius();
                        if (updated.isNotEmpty && !_instructorsSheetVisible) {
                          _instructorsSheetVisible = true;
                          showModalBottomSheet(
                            context: context,
                            builder: (_) =>
                                InstructorsBottomSheet(instructors: updated),
                          ).whenComplete(() {
                            _instructorsSheetVisible = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
