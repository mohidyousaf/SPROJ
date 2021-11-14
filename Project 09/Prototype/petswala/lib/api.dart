import 'package:dio/dio.dart';

import 'package:petswala/storeitem.dart';

class ProductsApi {
  final _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8081/'));

  Future<List<Storeitem>> getPSProducts() async {
    final response = await _dio.get('PSProducts');
    return (response.data['products'] as List)
        .map<Storeitem>((json) => Storeitem.fromJson(json))
        .toList();
  }

  Future<List<Storeitem>> getAllProducts() async {
    final response = await _dio.get('AllProducts');
    return (response.data['products'] as List)
        .map<Storeitem>((json) => Storeitem.fromJson(json))
        .toList();
  }

  Future<Storeitem> addProduct(String storename,String productname, int price, int quantity) async {
    final response = await _dio.post('AddProduct', data: {"productname":productname, "storename":storename,'price':price,'quantity':quantity});
    return Storeitem.fromJson(response.data);
  }

  Future deleteContact(String name) async {
    final response = await _dio.delete('/$name');
    return response.data;
  }
}
