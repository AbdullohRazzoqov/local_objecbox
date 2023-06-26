// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;

  String name;
  int age;

  @Property(type: PropertyType.date)
  DateTime? date;

  @Transient()
  int? computedProperty;
  User({
    required this.name,
    required this.age,
    this.date,
    this.computedProperty,
  });
}
