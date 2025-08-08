import 'package:flutter/material.dart';
import 'package:proxima/config/theme.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/chat_list/main_page.dart';
import 'package:proxima/pages/course/main_page.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
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
        primary: Color(0xFF351C1D),
        primaryAccent: Color.fromARGB(255, 102, 56, 59),
        textPrimary: Color(0xFFFFFFFF),
        secondary: Color(0xFFB28F5F),
        secondaryAccent: Color(0xFFDAB986),
        textSecondary: Color(0xFF000000),
        tertiaty: Color(0xFF1F1F1F),
        tertiaryAccent: Color(0xFF383838),
        surface: Color(0xFFFFFFF5),
        secondarySurface: Color(0xFFFFFFFD),
        error: Color(0xFF4E0000),
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

    final List<Widget> buttons = [
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
            MaterialPageRoute(builder: (context) => ReviewMainPage(userId: '4444-abc', classId: 'eng12')),
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
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CourseCreationMainPage()),
          );
        },
        child: Text('Course creation'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Temporary home page')),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: buttons
            .map((button) => Padding(padding: EdgeInsets.all(4), child: button))
            .toList(),
      ),
    );
  }
}
