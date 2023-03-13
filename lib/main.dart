import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.black12,
        buttonTheme: ButtonTheme.of(context).copyWith(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      // home: ChatScreen(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Zoope'),
            actions: [
              PopupMenuButton(itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 5),
                          Text('Logout'),
                        ],
                      ),
                    ),
                  )
                ];
              })
              // DropdownButton(
              //   icon: Icon(Icons.more_vert_sharp),
              //   items: [
              //     DropdownMenuItem(
              //       child: Container(
              //         child: Row(
              //           children: [
              //             Icon(Icons.exit_to_app_rounded),
              //             SizedBox(width: 5),
              //             Text('Logout'),
              //           ],
              //         ),
              //       ),
              //       value: 'logout',
              //     )
              //   ],
              //   onChanged: (value) {
              //     if (value == 'logout') {
              //       FirebaseAuth.instance.signOut();
              //     }
              //   },
              // )
            ],
          ),
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((ctx, snapshot) {
                if (snapshot.hasData) {
                  return ChatScreen();
                }
                return AuthScreen();
              }))),
    );
  }
}
