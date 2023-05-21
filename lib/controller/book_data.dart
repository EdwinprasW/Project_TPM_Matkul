import '../service/base_network.dart';

//Dengan memanggil method loadBooks(),  mengembalikan nilai dari class
//BaseNetwork dengan method get() diisi dengan parameter “text” dikarenakan ingin
//mengambil list dari buku-buku.

class BookDataSource {
  static BookDataSource instance = BookDataSource();
  Future<Map<String, dynamic>> loadBooks(String text) {
    return BaseNetwork.get(text);
  }
}