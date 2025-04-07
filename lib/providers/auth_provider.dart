import 'package:flutter/foundation.dart';
import 'package:todo_demo_app/models/user.dart';
import 'package:todo_demo_app/services/api_service.dart';
import 'package:todo_demo_app/utils/secure_storage.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final ApiService _apiService = ApiService();
  late final SecureStorageService _secureStorageService;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      _user = await _apiService.login(email, password);
      await _secureStorageService.write('jwt', _user!.jwt);
      notifyListeners();
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<void> loadUser() async {
    String jwt = await _secureStorageService.read('jwt');
    _user = User(id: '1', email: 'testing@gmail.com', jwt: jwt);
    notifyListeners();
  }

  void logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    notifyListeners();
  }
}