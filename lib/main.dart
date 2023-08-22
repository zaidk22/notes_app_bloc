import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app_bloc/Presentation/core/app_widget.dart';
import 'package:notes_app_bloc/injection.dart';

void main() async {
  
      WidgetsFlutterBinding.ensureInitialized();
    
  configureInjection(Environment.prod);
  await Firebase.initializeApp();
  runApp(const AppWidget());
}

