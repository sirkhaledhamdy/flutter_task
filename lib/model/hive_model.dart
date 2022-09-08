import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0 , adapterName: 'HiveUserAdapter')
class HiveUser{

  @HiveField(0)
   final String image;
     @HiveField(1)
   final int id;
     @HiveField(2)
   final String firstName;
    @HiveField(3)
   final String lastName;
  @HiveField(4)
  final int index;


  HiveUser({required this.image , required this.id , required this.firstName , required this.lastName , required this.index});

}