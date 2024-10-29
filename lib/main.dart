import 'package:flutter/material.dart';
import 'package:my_counter_app/my_app.dart';
import 'package:my_counter_app/service_provider.dart';

void main() {
  ServiceProvider.instance.init();
  runApp(const MyApp());
}
