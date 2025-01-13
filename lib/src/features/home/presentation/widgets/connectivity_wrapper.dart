import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/connectivity_service.dart';
import '../../../../my_app.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  @override
  void initState() {
    super.initState();
    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    connectivityService.addListener(_showConnectivitySnackbar);
  }

  void _showConnectivitySnackbar() {
    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);

    if (!connectivityService.isConnected) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('❌ Sin conexión a internet'),
          duration: Duration(days: 1),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      scaffoldMessengerKey.currentState?.clearSnackBars();
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text('✅ Conectado a Internet'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    Provider.of<ConnectivityService>(context, listen: false).removeListener(_showConnectivitySnackbar);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}