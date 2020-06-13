import 'package:dealjava/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store _store = Provider.of<Store>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan (Meja-diyo-${_store.tableNumber()})"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Pesananku",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[200],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 10.0,
                              backgroundColor: Color(0xFFF1523F),
                              child: Icon(
                                Icons.fastfood,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              "Add Menu",
                              style: TextStyle(
                                color: Color(0xFFF1523F),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Column(
                  children: _store.basket().map((basketItem) {
                    final int index = _store.basket().indexOf(basketItem);
                    return Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1523F),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  '${basketItem["quantity"].toString()}x',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    basketItem["name"],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(basketItem["note"]),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                _store.formatPrice(basketItem["price"] * basketItem["quantity"]),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              InkWell(
                                onTap: () => _store.removeFromBasket(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFF1523F),
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Color(0xFFF1523F),
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Divider(thickness: 1.0),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text(_store.getTotal()),
                  ],
                ),
                SizedBox(height: height * 0.06),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 0.01,
                  ),
                  height: height * 0.015,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Kode Promo",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: width * 0.04,
                          width: width * 0.04,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Text("Masukan")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              child: FlatButton(
                onPressed: () {
                  _store.checkout();
                  Navigator.pushNamed(context, '/shop-detail');
                },
                color: Color(0xFFF1523F),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.06,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width * 0.09,
                      height: width * 0.08,
                      decoration: BoxDecoration(
                        color: Color(0xFFC8312B),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        )
                      ),
                      child: Center(
                        child: Text(
                          _store.getBasketLength(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _store.getTotal(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}