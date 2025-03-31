import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo_app/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"),),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: () async {
           try {
             await Provider.of<AuthProvider>(context, listen: false).login(_emailController.text, _passwordController.text);
           }catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed')));
           }
          }, child: const Text("Login"))
        ],),
      ),
    );
  }
}