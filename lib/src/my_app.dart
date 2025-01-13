import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/connectivity_service.dart';
import 'features/home/data/repositories/res_partner_repository.dart';
import 'features/home/presentation/blocs/res_partner_provider.dart';
import 'features/home/presentation/widgets/connectivity_wrapper.dart';
import 'features/home/presentation/screens/home_screen.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
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
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: ConnectivityWrapper(child: MyHomePage(title: 'Offline First')),
      ),
    );
  }
}
