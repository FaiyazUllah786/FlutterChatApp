import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //auth object manage by firebase auth package
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm({
    required String email,
    required String username,
    required XFile userimage,
    required String password,
    required bool isLogin,
  }) async {
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential _authResult;
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
//ref reference to root dir of firebase storage bucket
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(_authResult.user!.uid + '.jpg');
        await ref.putFile(File(userimage.path)).then((_) => null);
        //adding user name in signup block
        //creating new collection for user also document and setting(updating/add) data in it
        //accessing image we upload
        final imageUrl = await ref.getDownloadURL();
        FirebaseFirestore.instance
            .collection('user')
            .doc(_authResult.user!.uid)
            .set({
          'user': username,
          'email': email,
          'imageURL': imageUrl,
        });
      }
    } on PlatformException catch (e) {
      var message = 'An error occurded\nplease check your credentials';
      if (e.message != null) {
        message = e.message!;
      }
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('okay'),
            )
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('okay'),
            )
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      body: AuthForm(submitHelper: _submitAuthForm, isLoding: _isLoading),
    );
  }
}
