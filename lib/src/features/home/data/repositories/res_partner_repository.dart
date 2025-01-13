import 'dart:developer';

import '../../../../../main.dart';
import '../../domain/data/objectbox.g.dart';
import '../../domain/entities/res_partner_model.dart';
import '../../domain/entities/res_partner_timestamp_model.dart';
import '../../domain/entities/sync_state_model.dart';

abstract class ResPartnerRepository {
  int createPartner(String name);
  void checkInPartner(int partnerId);
  void checkOutPartner(int partnerId);
  List<ResPartnerModel> getAllPartners();
  List<ResPartnerTimestamp> getTimestampsByPartnerId(int partnerId);
  List<ResSyncState> getAllSyncStates();
  void removeAllPartners();
  void removeSyncState();
}

class ResPartnerRepositoryObjectBox implements ResPartnerRepository {
  final partnerBox = objectbox.store.box<ResPartnerModel>();
  final timestampBox = objectbox.store.box<ResPartnerTimestamp>();
  final syncStateBox = objectbox.store.box<ResSyncState>();

  @override
  int createPartner(String name) {
    // Verificar si ya existe un registro con el mismo nombre
    final existingPartner = partnerBox
        .query(ResPartnerModel_.name.equals(name))
        .build()
        .findFirst();

    if (existingPartner != null) {
      log('Ya existe un partner con el nombre $name');
      return -1;
    }

    final partner = ResPartnerModel(name: name, activeIn: false);
    final partnerId = partnerBox.put(partner);

    final syncState = ResSyncState(
      resModel: 'res.partner',
      resId: partnerId.toString(),
      sync: false,
      action: 'create',
      updateDate: DateTime.now(),
      syncDate: DateTime.now(),
      changes: {
        'name': name,
        'activeIn': partner.activeIn.toString(),
      },
    );
    syncStateBox.put(syncState);
    return partnerId;
  }

  @override
  void checkInPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner != null) {
      partner.lastIn = DateTime.now();
      partner.activeIn = true;
      partnerBox.put(partner);

      // Crear un nuevo timestamp
      final timestamp = ResPartnerTimestamp(
        partnerId: partnerId,
        timestamp: DateTime.now(),
        type: 'IN',
      );
      timestampBox.put(timestamp);

      // Guardar en SyncState el cambio en ResPartnerModel
      final existingSyncStatePartner = syncStateBox
          .query(ResSyncState_.resId
              .equals(partnerId.toString())
              .and(ResSyncState_.resModel.equals('res.partner')))
          .build()
          .findFirst();

      if (existingSyncStatePartner != null) {
        existingSyncStatePartner.changes = {
          'lastIn': partner.lastIn.toString(),
          'activeIn': partner.activeIn.toString(),
        };
        existingSyncStatePartner.updateDate = DateTime.now();
        existingSyncStatePartner.sync = false;
        existingSyncStatePartner.action = 'update';
        syncStateBox.put(existingSyncStatePartner);
      }

      // Guardar en SyncState el cambio en ResPartnerTimestamp
      final syncStateTimestamp = ResSyncState(
        resModel: 'res.partner.timestamp',
        resId: timestamp.id.toString(),
        sync: false,
        action: 'create',
        updateDate: DateTime.now(),
        syncDate: DateTime.now(),
        changes: {
          'partnerId': timestamp.partnerId.toString(),
          'timestamp': timestamp.timestamp.toString(),
          'type': timestamp.type,
        },
      );
      syncStateBox.put(syncStateTimestamp);
    }
  }

  @override
  void checkOutPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner != null) {
      partner.lastOut = DateTime.now();
      partner.activeIn = false;
      partnerBox.put(partner);

      // Crear un nuevo timestamp
      final timestamp = ResPartnerTimestamp(
        partnerId: partnerId,
        timestamp: DateTime.now(),
        type: 'OUT',
      );
      timestampBox.put(timestamp);

      // Guardar en SyncState el cambio en ResPartnerModel
      final existingSyncStatePartner = syncStateBox
          .query(ResSyncState_.resId
              .equals(partnerId.toString())
              .and(ResSyncState_.resModel.equals('res.partner')))
          .build()
          .findFirst();

      if (existingSyncStatePartner != null) {
        existingSyncStatePartner.changes = {
          'lastOut': partner.lastOut.toString(),
          'activeIn': partner.activeIn.toString(),
        };
        existingSyncStatePartner.updateDate = DateTime.now();
        existingSyncStatePartner.sync = false;
        existingSyncStatePartner.action = 'update';
        syncStateBox.put(existingSyncStatePartner);
      }

      // Guardar en SyncState el cambio en ResPartnerTimestamp
      final syncStateTimestamp = ResSyncState(
        resModel: 'res.partner.timestamp',
        resId: timestamp.id.toString(),
        sync: false,
        action: 'create',
        updateDate: DateTime.now(),
        syncDate: DateTime.now(),
        changes: {
          'partnerId': timestamp.partnerId.toString(),
          'timestamp': timestamp.timestamp.toString(),
          'type': timestamp.type,
        },
      );
      syncStateBox.put(syncStateTimestamp);
    }
  }

  @override
  List<ResPartnerModel> getAllPartners() {
    return partnerBox.getAll();
  }

  @override
  List<ResPartnerTimestamp> getTimestampsByPartnerId(int partnerId) {
    return timestampBox
        .getAll()
        .where((t) => t.partnerId == partnerId)
        .toList();
  }

  @override
  List<ResSyncState> getAllSyncStates() {
    return syncStateBox.getAll();
  }

  @override
  void removeAllPartners() {
    partnerBox.removeAll();
    timestampBox.removeAll();
    syncStateBox.removeAll();
  }

  @override
  void removeSyncState() {
    syncStateBox.removeAll();
  }
}
