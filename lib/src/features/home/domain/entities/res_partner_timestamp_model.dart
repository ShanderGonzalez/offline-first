import 'package:objectbox/objectbox.dart';

@Entity()
class ResPartnerTimestamp {
  @Id()
  int id = 0;
  @Index()
  String uuid;
  String partnerId;
  @Property(type: PropertyType.date)
  DateTime timestamp;
  String type;

  ResPartnerTimestamp({
    this.id = 0,
    required this.uuid,
    required this.partnerId,
    required this.timestamp,
    required this.type,
  });
}
