import 'package:flutter/material.dart';
import 'package:proxima/pages/map/main_page.dart';
import 'pages/video_call/main_page.dart';
import 'pages/calendar/main_page.dart';
import 'pages/user/main_page.dart';
import 'pages/class/main_page.dart';
import 'classes/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: DebugPages()));
}

class DebugPages extends StatelessWidget {
  const DebugPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temporary home page', style: TextStyle(color: Colors.deepPurple[800], fontSize: 24))),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.deepPurple[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarMainPage(),
                  ),
                );
              },
              child: Text('Calendar', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.deepPurple[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoCallMainPage(),
                  ),
                );
              },
              child: Text('VideoCall', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.deepPurple[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserMainPage()),
                );
              },
              child: Text('User', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.deepPurple[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassMainPage()),
                );
              },
              child: Text('Course', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.deepPurple[300],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapMainPage()),
                );
              },
              child: Text('Map', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
