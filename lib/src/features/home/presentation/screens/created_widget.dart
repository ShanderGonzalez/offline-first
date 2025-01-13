import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/res_partner_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CreatedWidget extends StatelessWidget {
  late final TextEditingController _nameController = TextEditingController();

  CreatedWidget({super.key});

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
            CustomTextField(controller: _nameController, label: 'Nombre'),
            SizedBox(height: 20),
            CustomButton(
              label: 'Crear',
              onPressed: () {
                partnerProvider.createPartner(_nameController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Partner Creado')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
