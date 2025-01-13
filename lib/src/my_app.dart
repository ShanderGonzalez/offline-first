import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/data/repositories/res_partner_repository.dart';
import 'features/home/presentation/blocs/res_partner_provider.dart';
import 'features/home/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ResPartnerRepository>(
          create: (_) => ResPartnerRepositoryObjectBox(),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                ResPartnerProvider(context.read<ResPartnerRepository>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Offline First',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Offline First'),
      ),
    );
  }
}
