import 'dart:convert';

import 'package:http/http.dart' as http;
import '../consts/api_consts.dart';
import '../models/categories_model.dart';
import '../models/products_model.dart';
import '../models/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target}) async {
    var uri = Uri.https(
      BASE_URL,
      "api/v1/$target",
    );
    var response = await http.get(uri);

    // print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("V $v \n\n");
    }
    return tempList;
  }

  static Future<List<ProductsModel>> getAllProducts() async {
    List temp = await getData(target: "products");
    return ProductsModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoriesModel>> getAllCategories() async {
    List temp = await getData(target: "categories");
    return CategoriesModel.categoriesFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    return UsersModel.usersFromSnapshot(temp);
  }

  static Future<ProductsModel> getProductById({required String id}) async {
    var uri = Uri.https(
      BASE_URL,
      "api/v1/products/$id",
    );
    var response = await http.get(uri);

    // print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);

    return ProductsModel.fromJson(data);
  }
}
