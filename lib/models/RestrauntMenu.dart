import 'package:get/get.dart';

class RestrauntMenu extends GetxController{

var RestrauntItems=[];


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    RestrauntItems= [
      { "id":1,
        "title": 'Idly(2Pcs) (Breakfast)',
        "price": 'Rs48',
        "image": 'assets/images/food1.jpg',
        "desc":
            'A healthy breakfast item and an authentic south indian delicacy! Steamed and fluffy rice cake..more',
        "AddedToCart":false,
      },
      {"id":2,
        "title": 'Sambar Idly (2Pcs)',
        "image": 'assets/images/food2.jpg',
        "price": 'Rs70',
        "AddedToCart":false,
      },
      {"id":3,
        "title": 'Ghee Pongal',
        "image": 'assets/images/food3.jpg',
        "price": 'Rs85',
        "desc":
            'Cute, button idlis with authentic. South Indian sambar and coconut chutney gives the per..more',
        "AddedToCart":false,
      },
      {"id":4,
        "title": 'Boori (1Set)',
        "image": 'assets/images/food4.jpg',
        "price": 'Rs85',
        "AddedToCart":false,
      },
      {"id":5,
        "title": 'Podi Idly(2Pcs)',
        "image": 'assets/images/food5.jpg',
        "price": 'Rs110',
        "AddedToCart":false,
      },
      {
        "id":6,
        "title": 'Mini Idly with Sambar',
        "image": 'assets/images/food6.jpg',
        "price": 'Rs85',
        "desc":
            'Cute, button idlis with authentic. South Indian sambar and coconut chutney gives the per..more',
        "AddedToCart":false,
      },
    ];
    update();
  }


void AddtoCartStatus(index){
  RestrauntItems[index]["AddedToCart"]=true;
  update();
}

void AddtoCartStatusFalse(id){

  RestrauntItems.forEach((item){
   if(item["id"]==id){
     item["AddedToCart"]=false;
   }
  });
  update();
}




}