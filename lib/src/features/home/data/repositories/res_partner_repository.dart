import 'dart:developer';

import 'package:uuid/uuid.dart';

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
  final uuid = Uuid();

  @override
  int createPartner(String name) {
    final existingPartnerQuery =
        partnerBox.query(ResPartnerModel_.name.equals(name)).build();
    final existingPartner = existingPartnerQuery.findFirst();

    if (existingPartner != null) {
      log('Ya existe un partner con el nombre $name');
      return -1;
    }

    final partner =
        ResPartnerModel(uuid: uuid.v4(), name: name, activeIn: false);
    final partnerId = partnerBox.put(partner);

    final syncState = ResSyncState(
      resModel: 'res.partner',
      resId: partner.uuid.toString(),
      sync: false,
      action: 'create',
      updateDate: DateTime.now(),
      changes: {
        'uuid': partner.uuid,
        'name': partner.name,
        'activeIn': partner.activeIn.toString(),
      },
    );
    syncStateBox.put(syncState);
    return partnerId;
  }

  @override
  void checkInPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner == null) return;

    partner.lastIn = DateTime.now();
    partner.activeIn = true;
    partnerBox.put(partner);

    final resPartner = ResSyncState(
      resModel: 'res.partner',
      resId: partner.uuid.toString(),
      sync: false,
      action: 'update',
      updateDate: DateTime.now(),
      changes: {
        'lastIn': partner.lastIn.toString(),
        'activeIn': partner.activeIn.toString(),
      },
    );
    syncStateBox.put(resPartner);

    final timestamp = ResPartnerTimestamp(
      uuid: uuid.v4(),
      partnerId: partner.uuid.toString(),
      timestamp: DateTime.now(),
      type: 'IN',
    );
    timestampBox.put(timestamp);

    final syncStateTimestamp = ResSyncState(
      resModel: 'res.partner.timestamp',
      resId: timestamp.uuid.toString(),
      sync: false,
      action: 'create',
      updateDate: DateTime.now(),
      changes: {
        'uuid': timestamp.uuid.toString(),
        'partnerId': partner.uuid.toString(),
        'timestamp': timestamp.timestamp.toString(),
        'type': timestamp.type,
      },
    );
    syncStateBox.put(syncStateTimestamp);
  }

  @override
  void checkOutPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner == null) return;

    partner.lastOut = DateTime.now();
    partner.activeIn = false;
    partnerBox.put(partner);

    final resPartner = ResSyncState(
      resModel: 'res.partner',
      resId: partner.uuid.toString(),
      sync: false,
      action: 'update',
      updateDate: DateTime.now(),
      changes: {
        'lastOut': partner.lastOut.toString(),
        'activeIn': partner.activeIn.toString(),
      },
    );
    syncStateBox.put(resPartner);

    final timestamp = ResPartnerTimestamp(
      uuid: uuid.v4(),
      partnerId: partner.uuid.toString(),
      timestamp: DateTime.now(),
      type: 'OUT',
    );
    timestampBox.put(timestamp);

    final syncStateTimestamp = ResSyncState(
      resModel: 'res.partner.timestamp',
      resId: timestamp.uuid.toString(),
      sync: false,
      action: 'create',
      updateDate: DateTime.now(),
      changes: {
        'uuid': timestamp.uuid.toString(),
        'partnerId': partner.uuid.toString(),
        'timestamp': timestamp.timestamp.toString(),
        'type': timestamp.type,
      },
    );
    syncStateBox.put(syncStateTimestamp);
  }

  @override
  List<ResPartnerModel> getAllPartners() => partnerBox.getAll();

  @override
  List<ResPartnerTimestamp> getTimestampsByPartnerId(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner == null) return [];
    return timestampBox
        .query(ResPartnerTimestamp_.partnerId.equals(partner.uuid.toString()))
        .build()
        .find();
  }

  @override
  List<ResSyncState> getAllSyncStates() => syncStateBox.getAll();

  @override
  void removeAllPartners() {
    partnerBox.removeAll();
    timestampBox.removeAll();
    syncStateBox.removeAll();
  }

  @override
  void removeSyncState() => syncStateBox.removeAll();
}
