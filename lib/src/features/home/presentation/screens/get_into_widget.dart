import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/res_partner_model.dart';
import '../blocs/res_partner_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'go_out_widget.dart';

class GetIntoWidget extends StatefulWidget {
  const GetIntoWidget({super.key});

  @override
  State<GetIntoWidget> createState() => _GetIntoWidgetState();
}

class _GetIntoWidgetState extends State<GetIntoWidget> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? lastCheckOut;

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
                        (a.lastOut ?? DateTime(0))
                                .isAfter(b.lastOut ?? DateTime(0))
                            ? a
                            : b);

                    setState(() {
                      lastCheckOut = latestPartner.lastOut;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Partner encontrado: ${latestPartner.name}')),
                    );
                  } else {
                    setState(() {
                      lastCheckOut = null;
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
              label: 'Ingresar',
              onPressed: () {
                final partner = partnerProvider.partners.firstWhere(
                  (p) => p.name == _nameController.text,
                  orElse: () =>
                      ResPartnerModel(uuid: '', name: '', activeIn: false),
                );

                if (partner.id != 0) {
                  partnerProvider.checkIn(partner.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Check-in realizado para ${partner.name}')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoOutWidget()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Partner no encontrado')),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text(lastCheckOut != null
                ? 'Última salida: $lastCheckOut'
                : 'Último salida no registrado'),
          ],
        ),
      ),
    );
  }
}
