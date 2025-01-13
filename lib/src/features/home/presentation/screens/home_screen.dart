import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/res_partner_provider.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'created_widget.dart';
import 'get_into_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<ResPartnerProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: title),
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
          ],
        ),
      ),
    );
  }
}
