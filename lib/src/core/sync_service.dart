import 'package:offline_first/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/home/domain/data/objectbox.g.dart';
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
}
