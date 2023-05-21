import 'package:hive/hive.dart';
part 'book_lib.g.dart'; // digunakan untuk generate file menggunakan build_runner

@HiveType(typeId: 0)
class Lib extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String imageLink;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String authors;


  Lib({
    required this.imageLink,
    required this.title,
    required this.authors
  });
}