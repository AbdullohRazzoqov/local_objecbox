import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id = 0;
  
  String? name;
  
  @Property(type: PropertyType.date)
  DateTime? date;

  @Transient() 
  int? computedProperty;
}