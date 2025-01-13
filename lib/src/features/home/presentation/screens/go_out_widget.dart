import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  DateTime? lastCheckIn;

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<ResPartnerProvider>(context);

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

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Partner encontrado: ${latestPartner.name}')),
                    );
                  } else {
                    setState(() {
                      lastCheckIn = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Partner no encontrado')),
                    );
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
                  orElse: () => ResPartnerModel(name: '', activeIn: false),
                );

                if (partner.id != 0 && partner.activeIn) {
                  partnerProvider.checkOut(partner.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Salida registrada para ${partner.name}')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('El partner no está activo o no existe')),
                  );
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
                partnerProvider.removeSyncState();
              },
            ),
          ],
        ),
      ),
    );
  }
}
