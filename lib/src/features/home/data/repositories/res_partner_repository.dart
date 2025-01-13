import '../../../../../main.dart';
import '../../domain/entities/res_partner_model.dart';
import '../../domain/entities/res_partner_timestamp_model.dart';

abstract class ResPartnerRepository {
  int createPartner(String name);
  void checkInPartner(int partnerId);
  void checkOutPartner(int partnerId);
  List<ResPartnerModel> getAllPartners();
  List<ResPartnerTimestamp> getTimestampsByPartnerId(int partnerId);
  void removeAllPartners();
}

class ResPartnerRepositoryObjectBox implements ResPartnerRepository {
  final partnerBox = objectbox.store.box<ResPartnerModel>();
  final timestampBox = objectbox.store.box<ResPartnerTimestamp>();

  @override
  int createPartner(String name) {
    final partner = ResPartnerModel(name: name, activeIn: false);
    return partnerBox.put(partner);
  }

  @override
  void checkInPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner != null) {
      partner.lastIn = DateTime.now();
      partner.activeIn = true;
      partnerBox.put(partner);
      timestampBox.put(
        ResPartnerTimestamp(
          partnerId: partnerId,
          timestamp: DateTime.now(),
          type: 'IN',
        ),
      );
    }
  }

  @override
  void checkOutPartner(int partnerId) {
    final partner = partnerBox.get(partnerId);
    if (partner != null) {
      partner.lastOut = DateTime.now();
      partner.activeIn = false;
      partnerBox.put(partner);
      timestampBox.put(
        ResPartnerTimestamp(
          partnerId: partnerId,
          timestamp: DateTime.now(),
          type: 'OUT',
        ),
      );
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
  void removeAllPartners() {
    partnerBox.removeAll();
    timestampBox.removeAll();
  }
}
