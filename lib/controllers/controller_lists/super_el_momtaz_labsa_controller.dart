import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theblue_crown/controllers/cart_controller.dart';
import 'package:theblue_crown/models/products_model.dart';
import '../../data/repository/repo_lists/super_el_momtaz_labsa_repo.dart';

class SuperElMomtazLabsaController extends GetxController{
  final SuperElMomtazLabsaRepo superElMomtazLabsaRepo;

  SuperElMomtazLabsaController({required this.superElMomtazLabsaRepo});

  List<ProductModel> _superElMomtazLabsaList = [];
  List<ProductModel> get superElMomtazLabsaList => _superElMomtazLabsaList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getSuperElMomtazLabsaList() async {
    Response response = await superElMomtazLabsaRepo.getSuperElMomtazLabsaList();
    if(response.statusCode == 200) {
      _superElMomtazLabsaList = [];
      _superElMomtazLabsaList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      print(_superElMomtazLabsaList);
      print("..............................got el Momtaz Labsa..............................");
      update();
    }else{
      print("..............................could not get el Momtaz Labsa..............................");
    }
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

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id is " + value.id.toString() + " The quantity is " + value.quantity.toString());
    });
    update();
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
}