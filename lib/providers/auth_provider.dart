import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_demo_app/models/user.dart';
import 'package:todo_demo_app/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final ApiService _apiService = ApiService();
  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      _user = await _apiService.login(email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', _user!.jwt);
      notifyListeners();

    }catch(e){
      rethrow;
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');
    if(jwt != null){

      ApiService.jwt = jwt;
      _user = User(id: '1', email: 'testing@gmail.com', jwt: jwt);
      notifyListeners();
    }
  }

  void logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    notifyListeners();
  }
}