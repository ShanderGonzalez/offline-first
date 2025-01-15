// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../entities/res_partner_model.dart';
import '../entities/res_partner_timestamp_model.dart';
import '../entities/sync_state_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 4715259965584809057),
      name: 'ResPartnerModel',
      lastPropertyId: const obx_int.IdUid(6, 4468306379197946798),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 955344430201861180),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 6089756004787859990),
            name: 'uuid',
            type: 9,
            flags: 2048,
            indexId: const obx_int.IdUid(1, 6452324792105080591)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 3185175311369659969),
            name: 'name',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5104884190215220536),
            name: 'lastIn',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 7568660398319187019),
            name: 'lastOut',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 4468306379197946798),
            name: 'activeIn',
            type: 1,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 5089012186243122046),
      name: 'ResPartnerTimestamp',
      lastPropertyId: const obx_int.IdUid(5, 6528238436083052548),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7588978149630764835),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 2084126872140659331),
            name: 'uuid',
            type: 9,
            flags: 2048,
            indexId: const obx_int.IdUid(2, 2474319662255764460)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 2668477448363291803),
            name: 'partnerId',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 4793342792438017874),
            name: 'timestamp',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 6528238436083052548),
            name: 'type',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(3, 478878154904724081),
      name: 'ResSyncState',
      lastPropertyId: const obx_int.IdUid(8, 3202055172446252465),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1197153468798159247),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1048262380700063060),
            name: 'resModel',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8808944687595537443),
            name: 'resId',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 2292561684385408955),
            name: 'sync',
            type: 1,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 9206314246788878437),
            name: 'action',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 3516514165805939125),
            name: 'updateDate',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 4147332401959054286),
            name: 'syncDate',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 3202055172446252465),
            name: 'changesJson',
            type: 9,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(3, 478878154904724081),
      lastIndexId: const obx_int.IdUid(2, 2474319662255764460),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    ResPartnerModel: obx_int.EntityDefinition<ResPartnerModel>(
        model: _entities[0],
        toOneRelations: (ResPartnerModel object) => [],
        toManyRelations: (ResPartnerModel object) => {},
        getId: (ResPartnerModel object) => object.id,
        setId: (ResPartnerModel object, int id) {
          object.id = id;
        },
        objectToFB: (ResPartnerModel object, fb.Builder fbb) {
          final uuidOffset = fbb.writeString(object.uuid);
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uuidOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addInt64(3, object.lastIn?.millisecondsSinceEpoch);
          fbb.addInt64(4, object.lastOut?.millisecondsSinceEpoch);
          fbb.addBool(5, object.activeIn);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final lastInValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final lastOutValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 12);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final uuidParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final nameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final lastInParam = lastInValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(lastInValue);
          final lastOutParam = lastOutValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(lastOutValue);
          final activeInParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 14, false);
          final object = ResPartnerModel(
              id: idParam,
              uuid: uuidParam,
              name: nameParam,
              lastIn: lastInParam,
              lastOut: lastOutParam,
              activeIn: activeInParam);

          return object;
        }),
    ResPartnerTimestamp: obx_int.EntityDefinition<ResPartnerTimestamp>(
        model: _entities[1],
        toOneRelations: (ResPartnerTimestamp object) => [],
        toManyRelations: (ResPartnerTimestamp object) => {},
        getId: (ResPartnerTimestamp object) => object.id,
        setId: (ResPartnerTimestamp object, int id) {
          object.id = id;
        },
        objectToFB: (ResPartnerTimestamp object, fb.Builder fbb) {
          final uuidOffset = fbb.writeString(object.uuid);
          final partnerIdOffset = fbb.writeString(object.partnerId);
          final typeOffset = fbb.writeString(object.type);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, uuidOffset);
          fbb.addOffset(2, partnerIdOffset);
          fbb.addInt64(3, object.timestamp.millisecondsSinceEpoch);
          fbb.addOffset(4, typeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final uuidParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final partnerIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final timestampParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0));
          final typeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final object = ResPartnerTimestamp(
              id: idParam,
              uuid: uuidParam,
              partnerId: partnerIdParam,
              timestamp: timestampParam,
              type: typeParam);

          return object;
        }),
    ResSyncState: obx_int.EntityDefinition<ResSyncState>(
        model: _entities[2],
        toOneRelations: (ResSyncState object) => [],
        toManyRelations: (ResSyncState object) => {},
        getId: (ResSyncState object) => object.id,
        setId: (ResSyncState object, int id) {
          object.id = id;
        },
        objectToFB: (ResSyncState object, fb.Builder fbb) {
          final resModelOffset = fbb.writeString(object.resModel);
          final resIdOffset = fbb.writeString(object.resId);
          final actionOffset = fbb.writeString(object.action);
          final changesJsonOffset = fbb.writeString(object.changesJson);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, resModelOffset);
          fbb.addOffset(2, resIdOffset);
          fbb.addBool(3, object.sync);
          fbb.addOffset(4, actionOffset);
          fbb.addInt64(5, object.updateDate.millisecondsSinceEpoch);
          fbb.addInt64(6, object.syncDate?.millisecondsSinceEpoch);
          fbb.addOffset(7, changesJsonOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final syncDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final resModelParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final resIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final syncParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
          final actionParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final updateDateParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0));
          final syncDateParam = syncDateValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(syncDateValue);
          final object = ResSyncState(
              id: idParam,
              resModel: resModelParam,
              resId: resIdParam,
              sync: syncParam,
              action: actionParam,
              updateDate: updateDateParam,
              syncDate: syncDateParam)
            ..changesJson = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 18, '');

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [ResPartnerModel] entity fields to define ObjectBox queries.
class ResPartnerModel_ {
  /// See [ResPartnerModel.id].
  static final id =
      obx.QueryIntegerProperty<ResPartnerModel>(_entities[0].properties[0]);

  /// See [ResPartnerModel.uuid].
  static final uuid =
      obx.QueryStringProperty<ResPartnerModel>(_entities[0].properties[1]);

  /// See [ResPartnerModel.name].
  static final name =
      obx.QueryStringProperty<ResPartnerModel>(_entities[0].properties[2]);

  /// See [ResPartnerModel.lastIn].
  static final lastIn =
      obx.QueryDateProperty<ResPartnerModel>(_entities[0].properties[3]);

  /// See [ResPartnerModel.lastOut].
  static final lastOut =
      obx.QueryDateProperty<ResPartnerModel>(_entities[0].properties[4]);

  /// See [ResPartnerModel.activeIn].
  static final activeIn =
      obx.QueryBooleanProperty<ResPartnerModel>(_entities[0].properties[5]);
}

/// [ResPartnerTimestamp] entity fields to define ObjectBox queries.
class ResPartnerTimestamp_ {
  /// See [ResPartnerTimestamp.id].
  static final id =
      obx.QueryIntegerProperty<ResPartnerTimestamp>(_entities[1].properties[0]);

  /// See [ResPartnerTimestamp.uuid].
  static final uuid =
      obx.QueryStringProperty<ResPartnerTimestamp>(_entities[1].properties[1]);

  /// See [ResPartnerTimestamp.partnerId].
  static final partnerId =
      obx.QueryStringProperty<ResPartnerTimestamp>(_entities[1].properties[2]);

  /// See [ResPartnerTimestamp.timestamp].
  static final timestamp =
      obx.QueryDateProperty<ResPartnerTimestamp>(_entities[1].properties[3]);

  /// See [ResPartnerTimestamp.type].
  static final type =
      obx.QueryStringProperty<ResPartnerTimestamp>(_entities[1].properties[4]);
}

/// [ResSyncState] entity fields to define ObjectBox queries.
class ResSyncState_ {
  /// See [ResSyncState.id].
  static final id =
      obx.QueryIntegerProperty<ResSyncState>(_entities[2].properties[0]);

  /// See [ResSyncState.resModel].
  static final resModel =
      obx.QueryStringProperty<ResSyncState>(_entities[2].properties[1]);

  /// See [ResSyncState.resId].
  static final resId =
      obx.QueryStringProperty<ResSyncState>(_entities[2].properties[2]);

  /// See [ResSyncState.sync].
  static final sync =
      obx.QueryBooleanProperty<ResSyncState>(_entities[2].properties[3]);

  /// See [ResSyncState.action].
  static final action =
      obx.QueryStringProperty<ResSyncState>(_entities[2].properties[4]);

  /// See [ResSyncState.updateDate].
  static final updateDate =
      obx.QueryDateProperty<ResSyncState>(_entities[2].properties[5]);

  /// See [ResSyncState.syncDate].
  static final syncDate =
      obx.QueryDateProperty<ResSyncState>(_entities[2].properties[6]);

  /// See [ResSyncState.changesJson].
  static final changesJson =
      obx.QueryStringProperty<ResSyncState>(_entities[2].properties[7]);
}
