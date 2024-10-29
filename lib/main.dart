import 'package:flutter/material.dart';
import 'package:flutter_application_6/my_app.dart';
import 'package:flutter_application_6/service_provider.dart';

void main() {
  ServiceProvider.instance.init();
  runApp(const MyApp());
}
