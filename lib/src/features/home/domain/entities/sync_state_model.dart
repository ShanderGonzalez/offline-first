import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class ResSyncState {
  @Id()
  int id = 0;
  String resModel;
  String resId;
  bool sync;
  String action;
  @Property(type: PropertyType.date)
  DateTime updateDate;
  @Property(type: PropertyType.date)
  DateTime syncDate;

  @Property()
  String changesJson = '';

  @Transient()
  Map<String, dynamic> get changes => jsonDecode(changesJson);

  set changes(Map<String, dynamic> value) {
    changesJson = jsonEncode(value);
  }

  ResSyncState({
    this.id = 0,
    required this.resModel,
    required this.resId,
    required this.sync,
    required this.action,
    required this.updateDate,
    required this.syncDate,
    Map<String, dynamic>? changes,
  }) : changesJson = jsonEncode(changes ?? {});
}
