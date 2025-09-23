import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:proxima/classes/database/auth.dart';
import 'package:proxima/classes/util/preferences.dart';
import 'package:proxima/config/theme.dart';
import 'package:proxima/config/translation.dart';
import 'package:proxima/pages/home/main_page.dart';
import 'package:proxima/pages/init_account/main_page.dart';
import 'package:proxima/pages/suspended/main_page.dart';
import 'classes/database/database.dart';
import 'classes/models/user.dart';
import 'pages/welcome/main_page.dart';

late User currentUser;

extension Translation on String {
  String get tr => TranslationService.instance.translate(this);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  await Database().init();
  await navigateToRootAndAuth();
  await TranslationService.instance.load(currentUser.locale ?? 'en');
}

Future<void> navigateToRootAndAuth() async {
  final authStatus = await Auth().status;

  runApp(
    OKToast(
      child: ListenableBuilder(
        listenable: TranslationService.instance,
        builder: (context, _) {
          Widget home;

          switch (authStatus) {
            case AuthStatus.unauthenticated:
              home = WelcomeMainPage();
              break;

            case AuthStatus.pendingProfile:
              home = InitAccountMainPage(isInitialized: false);
              break;

            case AuthStatus.active:
              if (currentUser.suspended) {
                home = SuspendedMainPage();
              } else {
                home = HomeMainPage();
              }
              break;
          }

          return MaterialApp(
            theme: generateGreenTheme,
            debugShowCheckedModeBanner: false,
            home: home,
            locale: Locale(TranslationService.instance.currentLocale),
          );
        },
      ),
    ),
  );
}


// Initial debug home page
/*

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
            MaterialPageRoute(builder: (context) => ReviewMainPage(userId: '4444-abc', courseID: 'eng12')),
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
*/
