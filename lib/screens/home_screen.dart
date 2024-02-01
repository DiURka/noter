import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noter/providers/note_provider.dart';
import 'package:noter/services/auth_service.dart';
import 'note_signup.dart';
import 'note_login.dart';
import 'note_list_screen.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('NoteR', 
          style: TextStyle(
            fontWeight: FontWeight.w800,
          )
        ),
        actions: [
          if (authService.currentUser != null)
            FutureBuilder<Map<String, dynamic>?>(
              future: noteProvider.getUserData(authService.currentUser),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  Map<String, dynamic>? userData = snapshot.data;
                  String displayName = noteProvider.getDisplayName(authService.currentUser, userData);

                  return Row(
                    children: [
                      Text(displayName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () async {
                          await noteProvider.logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          if (authService.currentUser == null)
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthScreen()),
                    );
                  },
                  child: Text('Log In', 
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                  ),
                ),
              ],
            ),
        ],
      ),
      body: NoteListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (authService.currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNoteScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}