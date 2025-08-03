import 'package:flutter/material.dart';
import 'package:proxima/config/theme.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/chat_list/main_page.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'package:proxima/pages/map/main_page.dart';
import 'package:proxima/pages/review/main_page.dart';
import 'package:proxima/pages/search/main_page.dart';
import 'classes/database/database.dart';
import 'classes/models/user.dart';
import 'pages/account/main_page.dart';
import 'pages/video_call/main_page.dart';
import 'pages/calendar/main_page.dart';
import 'pages/user/main_page.dart';
import 'pages/welcome/main_page.dart';

late User currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();

  runApp(
    MaterialApp(
      theme: generateTheme(
        primary: Color(0xFF41682C),
        secondary: Color(0xFFC0F0A4),
        tertiaty: Color(0xFF072100),
        surface: Color(0xFFFFFFFF),
      ),
      debugShowCheckedModeBanner: false,
      home: DebugPages(),
    ),
  );
}

class DebugPages extends StatelessWidget {
  const DebugPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temporary home page')),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarMainPage()),
              );
            },
            child: Text('Calendar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoCallMainPage()),
              );
            },
            child: Text('VideoCall'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserMainPage()),
              );
            },
            child: Text('User'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CourseMainPage()),
              );
            },
            child: Text('Course'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapMainPage()),
              );
            },
            child: Text('Map'),
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
