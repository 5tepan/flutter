import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/shop_app.dart';

void main() async {
  // TODO:
  await dotenv.load(fileName: '.env');
  runApp(const ShopApp());
}
