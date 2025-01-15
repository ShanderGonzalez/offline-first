// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/connectivity_service.dart';
import '../../../../core/sync_service.dart';
import '../../domain/entities/res_partner_model.dart';
import '../blocs/res_partner_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class GoOutWidget extends StatefulWidget {
  const GoOutWidget({super.key});

  @override
  State<GoOutWidget> createState() => _GoOutWidgetState();
}

class _GoOutWidgetState extends State<GoOutWidget> {
  late final TextEditingController _nameController = TextEditingController();
  final SyncService syncService = SyncService();
  bool isSyncing = false;
  DateTime? lastCheckIn;

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<ResPartnerProvider>(context);
    final connectionProvider = Provider.of<ConnectivityService>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Offline First'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _nameController,
              label: 'Nombre',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final partners = partnerProvider.partners
                      .where((p) => p.name == _nameController.text)
                      .toList();

                  if (partners.isNotEmpty) {
                    final latestPartner = partners.reduce((a, b) =>
                        (a.lastIn ?? DateTime(0))
                                .isAfter(b.lastIn ?? DateTime(0))
                            ? a
                            : b);

                    setState(() {
                      lastCheckIn = latestPartner.lastIn;
                    });

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('✅ Partner encontrado')),
                      );
                    }
                  } else {
                    setState(() {
                      lastCheckIn = null;
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('❌ Partner no encontrado')),
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              label: 'Salir',
              onPressed: () {
                final partner = partnerProvider.partners.firstWhere(
                  (p) => p.name == _nameController.text,
                  orElse: () =>
                      ResPartnerModel(uuid: '', name: '', activeIn: false),
                );

                if (partner.id != 0 && partner.activeIn) {
                  partnerProvider.checkOut(partner.id);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ Salida exitosa')),
                    );
                  }
                  Navigator.pop(context);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('❌ Partner no encontrado')),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 20),
            Text(lastCheckIn != null
                ? 'Último ingreso: $lastCheckIn'
                : 'Último ingreso no registrado'),
            SizedBox(height: 20),
            CustomButton(
              label: 'Sincronizar',
              onPressed: () {
                () async {
                  try {
                    if (connectionProvider.isConnected) {
                      await syncService.syncToSupabase();
                      await syncService.syncFromSupabase();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('✅ Sincronización completada.')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('❌ No hay conexión a Internet.')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('❌ Error durante la sincronización: $e')),
                    );
                  }
                }();
              },
            )
          ],
        ),
      ),
    );
  }
}
