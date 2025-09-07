import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_resume_app/splash_screen.dart';

void main() {
  runApp(AiResumeApp());
}

class AiResumeApp extends StatefulWidget {
  const AiResumeApp({super.key});
  @override
  State<AiResumeApp> createState() => _AiResumeAppState();
}

class _AiResumeAppState extends State<AiResumeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}
