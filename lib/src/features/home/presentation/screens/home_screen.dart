import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/sync_service.dart';
import '../blocs/res_partner_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'created_widget.dart';
import 'get_into_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SyncService syncService = SyncService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await syncService.syncFromSupabase();
        log('Sincronización completada exitosamente.');
      } catch (e) {
        log('Error durante la sincronización: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<ResPartnerProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              label: 'Ir a vista crear',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatedWidget()),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Ir a vista ingresar',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetIntoWidget()),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Remover todos los partners',
              onPressed: partnerProvider.removeAllPartners,
            ),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Listar los partners',
              onPressed: partnerProvider.fetchPartners,
            ),
          ],
        ),
      ),
    );
  }
}
