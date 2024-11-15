import 'package:flutter/material.dart';
import 'package:proyek_akhir_dicoding/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Register the user
  void registerUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // Update user info
  void updateUser(String username, String email, String password) {
    _user = User(
      username: username,
      email: email,
      password: password,
    );
    notifyListeners();
  }

  // Login the user
  bool loginUser(String email, String password) {
    if (_user != null && _user!.email == email && _user!.password == password) {
      return true;
    }
    return false;
  }

  // Logout user
  void logoutUser() {
    _user = User(username: '', email: '', password: '');
    notifyListeners();
  }
}