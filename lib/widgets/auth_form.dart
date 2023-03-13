import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
  }) submitHelper;
  AuthForm({super.key, required this.submitHelper});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //form will mangage with this key
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      //use those values to send auth to firebase
      widget.submitHelper(
          email: _userEmail,
          username: _userName,
          password: _userPassword,
          isLogin: _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white.withOpacity(0.4),
        elevation: 10,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username length must be 5 or more';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password length must be 8 or more';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account?'
                          : 'I already have an account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
