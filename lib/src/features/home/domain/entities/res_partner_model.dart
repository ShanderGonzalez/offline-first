import 'package:objectbox/objectbox.dart';

@Entity()
class ResPartnerModel {
  @Id()
  int id = 0;
  String name;
  @Property(type: PropertyType.date)
  DateTime? lastIn;
  @Property(type: PropertyType.date)
  DateTime? lastOut;
  bool activeIn;

  ResPartnerModel({
    this.id = 0,
    required this.name,
    this.lastIn,
    this.lastOut,
    required this.activeIn,
  });
}
