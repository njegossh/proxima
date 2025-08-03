import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:proxima/pages/map/components/instructor_bottom_sheet.dart';

import 'controller.dart';

class MapMainPage extends StatefulWidget {
  const MapMainPage({super.key});

  @override
  State<MapMainPage> createState() => _MapMainPageState();
}

class _MapMainPageState extends State<MapMainPage> {
  final controller = MainMapController();

  @override
    void initState() {
      controller.init();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Map'),
            actions: [
              IconButton(
                onPressed: controller.getCurrentLocation,
                icon: Icon(Icons.my_location),
              ),
            ],
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(initialCenter: controller.userLocation, initialZoom: 13),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: controller.userLocation,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.person_pin_circle,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        ...controller.instructors.map(
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
                          point: controller.userLocation,
                          radius: controller.radius,
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
                        Text('Radius ${controller.radius.toInt()} meters'),
                        Slider(
                          min: 1000,
                          max: 100000,
                          divisions: 50,
                          value: controller.radius,
                          onChanged: controller.setRadius,
                          onChangeEnd: (value) async {
                            final updated = controller.getInstructorsWithinRadius();
                            if (updated.isNotEmpty && !controller.instructorsSheetVisible) {
                              controller.instructorsSheetVisible = true;
                              await showModalBottomSheet(
                                context: context,
                                builder: (_) =>
                                    InstructorsBottomSheet(instructors: updated),
                              );
                              controller.instructorsSheetVisible = false;
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
    );
  }
}