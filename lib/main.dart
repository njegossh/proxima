import 'package:flutter/material.dart';
import 'package:proxima/config/theme.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/chat_list/main_page.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'package:proxima/pages/map/main_page.dart';
import 'package:proxima/pages/review/main_page.dart';
import 'package:proxima/pages/search/main_page.dart';
import 'pages/account/main_page.dart';
import 'pages/video_call/main_page.dart';
import 'pages/calendar/main_page.dart';
import 'pages/user/main_page.dart';
import 'classes/database.dart';
import 'pages/welcome/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();

  runApp(MaterialApp(
    theme: generateTheme( 
      primary: Color(0xFF3E5F44),
      secondary: Color(0xFF5E936C),
      tertiaty: Color(0xFF93DA97),
      surface: Color(0xFFE8FFD7),
    ),
    debugShowCheckedModeBanner: false, 
    home: DebugPages(),
  ));
}

class DebugPages extends StatelessWidget {
  const DebugPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporary home page'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalendarMainPage(),
                  ),
                );
              },
              child: Text('Calendar'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoCallMainPage(),
                  ),
                );
              },
              child: Text('VideoCall'),
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassMainPage()),
                );
              },
              child: Text('Course'),
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountMainPage()),
                );
              },
              child: Text('Account'),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchMainPage()),
                );
              },
              child: Text('Search'),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatList()),
                );
              },
              child: Text('Chat List'),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeMainPage()),
                );
              },
              child: Text('Welcome'),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewMainPage()),
                );
              },
              child: Text('Review'),
            ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatMainPage()),
                );
              },
              child: Text('Chat'),
            ),
        ],
      ),
    );
  }
}
