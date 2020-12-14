import 'dart:io';

import 'package:afd_system/view/pages/pages.dart';
import 'package:afd_system/view/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) setWindowMinSize(Size(1080, 720));
  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
      theme: ThemeApp.get(),
    )
  );
}
