import 'package:flutter/material.dart';
import 'dart:io';

class AuthDoctorForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    String address,
    String qualification,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  AuthDoctorForm(this.submitFn, this.isLoading);
  @override
  _AuthDoctorFormState createState() => _AuthDoctorFormState();
}

class _AuthDoctorFormState extends State<AuthDoctorForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _username = '';
  var _password = '';
  var _email = '';
  var _address = '';
  var _qualification = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _email.trim(),
        _username.trim(),
        _password.trim(),
        _address.trim(),
        _qualification.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email adderess',
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _email = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter a valid username';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _username = newValue;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _password = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('qualification'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: 'Qualification',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter a valid qualification';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _qualification = newValue;
                        },
                      ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('address'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          labelText: 'Address',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter a valid address';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _address = newValue;
                        },
                      ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(
                          _isLogin ? 'Login' : 'Sign Up',
                        ),
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Create new account'
                              : 'I already have an account',
                        ),
                        textColor: Theme.of(context).primaryColor,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}