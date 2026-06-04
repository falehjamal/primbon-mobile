import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'presentation/providers/primbon_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PrimbonProvider(),
      child: const PrimbonApp(),
    ),
  );
}
