import 'package:get/get.dart';
import 'RestrauntMenu.dart';
class cartItems extends GetxController{
var items=[];
var TotalPrice=0;
var restraunt=Get.put(RestrauntMenu());

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    items=[];
  
    print(items);
    
    update();
  
  }

  void addItem(details){
     items.add(
      details
    );
    increase_total_price(int.parse(details["price"].substring(2)));
update();
  }
void increase_total_price(int increament){
TotalPrice+=increament;
update();
}
void decrease_total_price(int decreament){
TotalPrice-=decreament;
update();
}
void deleteItem(index){
  restraunt.AddtoCartStatusFalse(items[index]["id"]);
  items.removeAt(index);
  update();
}
}