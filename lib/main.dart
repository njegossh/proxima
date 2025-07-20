import 'package:flutter/material.dart';
import 'pages/video_call/main_page.dart';
import 'pages/calendar/main_page.dart';
import 'pages/user/main_page.dart';
import 'classes/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();

  runApp( 
    MaterialApp( 
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
      appBar: AppBar( 
        title: Text('Temp home'),
      ),
      body: ListView( 
        children: [ 
          TextButton(
            onPressed: (){ 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarMainPage(),
                ),
              );
            }, 
            child: Text('Calendar'),
          ),
          TextButton(
            onPressed: (){ 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideoCallMainPage(),
                ),
              );
            }, 
            child: Text('VideoCall'),
          ),
          TextButton(
            onPressed: (){ 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserMainPage(),
                ),
              );
            }, 
            child: Text('User'),
          ),
    
        ]
      ),
    );
  }
}
