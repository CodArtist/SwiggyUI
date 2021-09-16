import 'package:flutter/material.dart';
import 'package:swiggy_ui/utils/app_colors.dart';
import 'package:swiggy_ui/utils/ui_helper.dart';
import 'package:swiggy_ui/widgets/custom_divider_view.dart';
import 'package:swiggy_ui/widgets/veg_badge_view.dart';
import 'package:get/get.dart';
import 'package:swiggy_ui/models/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(cartItems());
    cartItems cart_items =Get.find();

    return Scaffold(
      body: SafeArea(
        child:
        cart_items.items.length==0?
        Center(child: Text("Your Cart is Empty Please Add Items"),):
         SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _OrderView(),
                const CustomDividerView(dividerHeight: 15.0),
                _CouponView(),
                const CustomDividerView(dividerHeight: 15.0),
                _BillDetailView(),
                _DecoratedView(),
                _AddressPaymentView(),
              ],
            ),
          ),
        ),
          
        ),
    
    );
  }
}

class _OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> {
  int cartCount = 1;

  @override
  Widget build(BuildContext context) {
    return
    GetBuilder<cartItems>(builder:(controller){ 
    return Container(
      height:500,
       
      child:ListView.builder(
      itemCount:controller.items.length,
      itemBuilder:(context,index){
    
    return cartitem(controller.items[index],index);
    }
      ),
    );
    }
    );
    
  }
}

class cartitem extends StatefulWidget {
  var item;
  var price;
  // var currentPrice;
  var itemIndex;
   cartitem(this.item,this.itemIndex){
   print("laskskkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
   this.price=int.parse(item["price"].substring(2));
  //  this.currentPrice=price;
  }

  @override
  _cartitemState createState() => _cartitemState();
}

class _cartitemState extends State<cartitem> {
  var cartCount=1;
  cartItems cart_items=Get.find();

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                widget.item["image"],
                height: 60.0,
                width: 60.0,
              ),
              UIHelper.horizontalSpaceSmall(),
              Column(
                children: <Widget>[
                  Text('Breakfast Express',
                      style: Theme.of(context).textTheme.subtitle2),
                  UIHelper.verticalSpaceExtraSmall(),
                  Text('OMR Perungudi',
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              )
            ],
          ),
          UIHelper.verticalSpaceLarge(),
          Row(
            children: <Widget>[
              const VegBadgeView(),
              UIHelper.horizontalSpaceSmall(),
              Flexible(
                child: Text(
                  widget.item["title"],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              UIHelper.horizontalSpaceSmall(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 35.0,
                width: 100.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: const Icon(Icons.remove, color: Colors.green),
                      onTap: () {
                        if (cartCount > 0) {
                          setState(() {
                            cartCount -= 1;
                            cart_items.decrease_total_price(widget.price);
                            if(cartCount==0){
                              cart_items.deleteItem(widget.itemIndex);
                            }
                          });
                          
                        }
                      },
                    ),
                    const Spacer(),
                    Text('$cartCount',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 16.0)),
                    const Spacer(),
                    InkWell(
                      child: const Icon(Icons.add, color: Colors.green),
                      onTap: () {
                        setState(() {
                          cartCount += 1;
                          cart_items.increase_total_price(widget.price);

                        });
                      },
                    )
                  ],
                ),
              ),
              UIHelper.horizontalSpaceSmall(),
              Text(
                'RS' + (widget.price*cartCount).toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          UIHelper.verticalSpaceExtraLarge(),
          CustomDividerView(
            dividerHeight: 1.0,
            color: Colors.grey[400],
          ),
          UIHelper.verticalSpaceMedium(),
          Row(
            children: <Widget>[
              Icon(Icons.library_books, color: Colors.grey[700]),
              UIHelper.horizontalSpaceSmall(),
              const Expanded(
                child: Text(
                    'Any restaurant request? We will try our best to convey it'),
              )
            ],
          ),
          UIHelper.verticalSpaceMedium(),
        ],
      ),
    );
     
  }
}



class _CouponView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.local_offer, size: 20.0, color: Colors.grey[700]),
          UIHelper.horizontalSpaceMedium(),
          Text(
            'APPLY COUPON',
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 16.0),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class _BillDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16.0);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child:  GetBuilder<cartItems>(
            builder: (controller){
              return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bill Details',
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 17.0),
          ),
          UIHelper.verticalSpaceSmall(),
        
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text('Item total', style: textStyle),

              Text('Rs '+controller.TotalPrice.toString(), style: textStyle),
            ],
          ),
        
          UIHelper.verticalSpaceMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Delivery Fee', style: textStyle),
                        UIHelper.horizontalSpaceSmall(),
                        const Icon(Icons.info_outline, size: 14.0)
                      ],
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      'Your Delivery Partner is travelling long distance to deliver your order',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              Text('Rs 54.00', style: textStyle),
            ],
          ),
          UIHelper.verticalSpaceLarge(),
          _buildDivider(),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Text('Taxes and Charges', style: textStyle),
                UIHelper.horizontalSpaceSmall(),
                const Icon(Icons.info_outline, size: 14.0),
                const Spacer(),
                Text('Rs 26.67', style: textStyle),
              ],
            ),
          ),
          _buildDivider(),
          Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Row(
              children: <Widget>[
                Text('To Pay', style: Theme.of(context).textTheme.subtitle2),
                const Spacer(),
                Text('Rs ' + (54+26.67+controller.TotalPrice).toString(), style: textStyle),
              ],
            ),
          ),
        ],
      );
            }
      )
    );
  }

  CustomDividerView _buildDivider() => CustomDividerView(
        dividerHeight: 1.0,
        color: Colors.grey[400],
      );
}

class _DecoratedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.grey[200],
    );
  }
}

class _AddressPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50.0,
          color: Colors.black,
          child: Row(
            children: <Widget>[
              Icon(Icons.phone, color: Colors.yellow[800]),
              UIHelper.horizontalSpaceSmall(),
              Expanded(
                child: Text(
                  'Want your order left outside? Call delivery executive',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: const Icon(Icons.add_location, size: 30.0),
                  ),
                  const Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
              UIHelper.horizontalSpaceMedium(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Deliver to Other',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16.0),
                    ),
                    Text(
                      'Keelkattalai',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey),
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      '43 MINS',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Text(
                  'ADD ADDRESS',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: darkOrange),
                ),
                onTap: () {},
              ),
              UIHelper.verticalSpaceMedium(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GetBuilder<cartItems>(builder:(controller){
                      return Text(
                      'Rs '+(26.67+54+controller.TotalPrice).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 16.0),
                    );
                    }
                    ),
                    UIHelper.verticalSpaceExtraSmall(),
                    Text(
                      'VIEW DETAIL BILL',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.blue, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                color: Colors.green,
                height: 58.0,
                child: Text(
                  'PROCEED TO PAY',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
