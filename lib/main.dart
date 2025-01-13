import 'package:flutter/material.dart';
import 'package:offline_first/src/my_app.dart';

import 'src/core/object_box.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  // await Supabase.initialize(
  //   url: Configuration.supabaseUrl,
  //   anonKey: Configuration.supabaseKey,
  // );
  runApp(const MyApp());
}
