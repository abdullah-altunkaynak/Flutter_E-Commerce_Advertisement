import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kumluk/controller/auth.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  
  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(onTap: () {
      AuthController.to.signOut();
    }, child: Container( color: Colors.red, child: Text('çıkış yap'),)),);
  }
}