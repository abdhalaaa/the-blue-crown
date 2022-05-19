import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/data/repository/repo_lists/recommended_product_repo.dart';
import 'package:theblue_crown/models/products_model.dart';

import '../cart_controller.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }else{
      print("could not get recommended popular");
    }
  }

  void setQuantity (bool isIncrement){
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //print("number of items " + _quantity.toString());
    }else{
      _quantity = checkQuantity(_quantity - 1);
      //print("decrement " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if(( _inCartItems + quantity ) < 0){
      Get.snackbar(
        "Item count", "You can't reduce more !",
        backgroundColor: Colors.grey.shade200,
        colorText: Colors.black,
      );
      if(_inCartItems > 0){
        _quantity = _inCartItems;
        return _quantity;
      }
      return 0;
    }else if(( _inCartItems + quantity ) > 20){
      Get.snackbar(
        "Item count", "You can't add more !",
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist= _cart.existInCart(product);
    //if exist
    //get from storage _inCartItems = 3
    //print("exist ot not " + exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    //print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is " + value.id.toString() + " The quantity is " + value.quantity.toString());
    });
    update();
  }
}


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/data/repository/popular_product_repo.dart';
import 'package:theblue_crown/data/repository/recommended_product_repo.dart';
import 'package:theblue_crown/models/products_model.dart';

import '../models/cart_model.dart';
import 'cart_controller.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;





  late CartController _cart;


  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;






  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200) {
      _recommendedProductList = [];
      recommendedProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    }else{
      print("could not get products recommended");
    }
  }






  void setQuantity (bool isIncrement){
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //print("number of items " + _quantity.toString());
    }else{
      _quantity = checkQuantity(_quantity - 1);
      //print("decrement " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity){
    if(( _inCartItems + quantity ) < 0){
      Get.snackbar(
        "Item count", "You can't reduce more !",
        backgroundColor: Colors.grey.shade200,
        colorText: Colors.black,
      );
      if(_inCartItems > 0){
        _quantity = _inCartItems;
        return _quantity;
      }
      return 0;
    }else if(( _inCartItems + quantity )>20){
      Get.snackbar(
        "Item count", "You can't add more !",
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist= _cart.existInCart(product);
    //if exist
    //get from storage _inCartItems = 3
    //print("exist ot not " + exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    //print("the quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is " + value.id.toString() + " The quantity is " + value.quantity.toString());
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }







}
 */