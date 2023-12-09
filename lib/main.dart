import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:noter/providers/note_provider.dart';
import 'package:noter/services/auth_service.dart';
import 'package:noter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        Provider<AuthService>(create: (_) => AuthService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note Taking App',
        theme: ThemeData(
          textTheme: GoogleFonts.salsaTextTheme(
            Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(fontSize: 24, letterSpacing: 1.2),
              headline2: TextStyle(fontSize: 20, letterSpacing: 1.0),
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}