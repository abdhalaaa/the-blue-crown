import 'package:get/get.dart';
import 'package:theblue_crown/data/repository/repo_lists/recommended_product_repo.dart';
import 'package:theblue_crown/models/products_model.dart';

import '../../data/repository/repo_lists/category_list_view_repo.dart';

class CategoryListViewController extends GetxController{
  final CategoryListViewRepo categoryListViewRepo;

  CategoryListViewController({required this.categoryListViewRepo});

  List<ProductModel> _categoryListViewList = [];
  List<ProductModel> get categoryListViewList => _categoryListViewList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCategoryListViewList() async {
    Response response = await categoryListViewRepo.getCategoryListViewList();
    if(response.statusCode == 200) {
      _categoryListViewList = [];
      _categoryListViewList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }else{
      print("could not get category list view");
    }
  }
}