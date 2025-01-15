import 'package:offline_first/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/home/domain/data/objectbox.g.dart';
import '../features/home/domain/entities/res_partner_model.dart';
import '../features/home/domain/entities/res_partner_timestamp_model.dart';
import '../features/home/domain/entities/sync_state_model.dart';

class SyncService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> syncToSupabase() async {
    final unsyncedStates = objectbox.store
        .box<ResSyncState>()
        .query(ResSyncState_.sync.equals(false))
        .build()
        .find();

    for (final state in unsyncedStates) {
      if (state.resModel == "res.partner") {
        if (state.action == "create") {
          await supabase.from('res_partner').insert(state.changes);
        }
        if (state.action == "update") {
          await supabase
              .from('res_partner')
              .update(state.changes)
              .eq('uuid', state.resId);
        }
      }
      if (state.resModel == "res.partner.timestamp") {
        if (state.action == "create") {
          await supabase.from('res_partner_timestamp').insert(state.changes);
        }
      }
      state.sync = true;
      state.syncDate = DateTime.now();
      objectbox.store.box<ResSyncState>().put(state);
    }
  }

  Future<void> syncFromSupabase() async {
    objectbox.store.box<ResPartnerModel>().removeAll();
    objectbox.store.box<ResPartnerTimestamp>().removeAll();
    objectbox.store.box<ResSyncState>().removeAll();

    final partnerBox = objectbox.store.box<ResPartnerModel>();
    final timestampBox = objectbox.store.box<ResPartnerTimestamp>();

    final partnersResponse = await supabase.from('res_partner').select('*');
    final timestampsResponse =
        await supabase.from('res_partner_timestamp').select('*');

    for (final partner in partnersResponse) {
      final partnerData = ResPartnerModel(
          uuid: partner['uuid'],
          name: partner['name'],
          lastIn: (partner['lastIn'] != null && partner['lastIn'] is String)
              ? DateTime.tryParse(partner['lastIn'])
              : null,
          lastOut: (partner['lastOut'] != null && partner['lastOut'] is String)
              ? DateTime.tryParse(partner['lastOut'])
              : null,
          activeIn: partner['activeIn']);
      partnerBox.put(partnerData);
    }

    for (final timestamp in timestampsResponse) {
      final timestampData = ResPartnerTimestamp(
        uuid: timestamp['uuid'],
        timestamp: DateTime.tryParse(timestamp['timestamp'])!,
        partnerId: timestamp['partnerId'],
        type: timestamp['type'],
      );
      timestampBox.put(timestampData);
    }
  }
}
