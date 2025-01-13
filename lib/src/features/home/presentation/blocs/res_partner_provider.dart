import 'dart:developer';

import 'package:flutter/material.dart';
import '../../data/repositories/res_partner_repository.dart';
import '../../domain/entities/res_partner_model.dart';
import '../../domain/entities/res_partner_timestamp_model.dart';
import '../../domain/entities/sync_state_model.dart';

class ResPartnerProvider with ChangeNotifier {
  final ResPartnerRepository _repository;
  List<ResPartnerModel> _partners = [];

  ResPartnerProvider(this._repository);

  List<ResPartnerModel> get partners => _partners;

  void fetchPartners() {
    _partners = _repository.getAllPartners();
    notifyListeners();
    _printDatabase();
    _printSyncState();
  }

  void createPartner(String name) {
    _repository.createPartner(name);
    fetchPartners();
  }

  void checkIn(int id) {
    _repository.checkInPartner(id);
    fetchPartners();
  }

  void checkOut(int id) {
    _repository.checkOutPartner(id);
    fetchPartners();
  }

  List<ResPartnerTimestamp> getTimestampsByPartnerId(int partnerId) {
    return _repository.getTimestampsByPartnerId(partnerId);
  }

  void removeAllPartners() {
    _repository.removeAllPartners();
    fetchPartners();
  }

  void removeSyncState() {
    _repository.removeSyncState();
    fetchPartners();
  }

  void _printDatabase() {
    log('=========== BASE DE DATOS ===========');
    for (var partner in _partners) {
      log('ID: ${partner.id}, Nombre: ${partner.name}, Last In: ${partner.lastIn}, Last Out: ${partner.lastOut}, Activo: ${partner.activeIn}');

      final timestamps = getTimestampsByPartnerId(partner.id);
      if (timestamps.isNotEmpty) {
        log('--- Timestamps ---');
        for (var i = 0; i < timestamps.length; i++) {
          log('   - ID: ${timestamps[i].id}, Fecha: ${timestamps[i].timestamp}, Tipo: ${timestamps[i].type}');
        }
      } else {
        log('   No tiene timestamps registrados.');
      }
    }
    log('======================================');
  }

  void _printSyncState() {
    final List<ResSyncState> syncStates = _repository.getAllSyncStates();
    log('=========== SYNC STATE ===========');
    for (var syncState in syncStates) {
      log('ID: ${syncState.id}');
      log('Modelo: ${syncState.resModel}');
      log('Recurso ID: ${syncState.resId}');
      log('Sincronizado: ${syncState.sync}');
      log('Acción: ${syncState.action}');
      log('Fecha Actualización: ${syncState.updateDate}');
      log('Fecha Sincronización: ${syncState.syncDate}');
      log('Cambios: ${syncState.changesJson}');
    }
    log('==================================');
  }
}
