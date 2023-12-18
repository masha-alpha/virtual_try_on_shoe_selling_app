import 'package:fit_studio_ar_app/models/products_list.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var _products={}.obs;

  void addProduct(ProductItem product){
    if(_products.containsKey(product)){
      _products[product] +=1;
    }
    else{
      _products[product] =1;
    }
  }

  void removeProduct(ProductItem product){
    if(_products.containsKey(product) && _products[product] == 1){
      _products.removeWhere((key, value) => key == product);
    }
    else{
      _products[product] -=1;
    }
  }

  get products => _products;

  get productSubTotal => _products.entries
  .map((product) => product.key.price *product.value)
  .toList();

  get total => _products.entries
  .map((product) => product.key.price *product.value)
  .toList()
  .reduce((value, element) => value + element)
  .toString();
}
