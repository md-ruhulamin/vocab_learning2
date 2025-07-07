import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final RxnString userName = RxnString();
  final TextEditingController nameController = TextEditingController();
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_name');
  }

  Future<void> saveUser(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    userName.value = name;
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    userName.value = null;
  }

  Future<void> updateUser(String name) async {
    await saveUser(name);
  }
}
