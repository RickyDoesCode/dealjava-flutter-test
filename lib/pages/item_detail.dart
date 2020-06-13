import 'package:dealjava/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _quantity = 1;
  String _note = '';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final Map item = arguments['item'];
    final double navBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Store _store = Provider.of<Store>(context);
    void addToBasket() {
      final Map basketItem = {
        'name': item['name'],
        'price': item['price'],
        'quantity': _quantity,
        'note': _note
      };
      _store.addToBasket(basketItem);
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: navBarHeight),
            child: Container(
              height: height - navBarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Hero(
                            tag: item['name'],
                            child: Image.network(
                              item['thumbnail'],
                              height: height * 0.25,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: height * 0.02,
                            left: width * 0.04,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFF1523F),
                                radius: width * 0.04,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height *0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  _store.formatPrice(item['price']),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFF1523F),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Divider(
                              height: 2.0,
                              thickness: 2.0,
                              color: Color(0xFFF1523F),
                            ),
                            SizedBox(height: height * 0.04),
                            Text(
                              "Special Request",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextFormField(
                              cursorColor: Color(0xFFF1523F),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Catatan untuk restoran',
                                border: InputBorder.none,
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _note = value;
                                });
                              },
                            ),
                            SizedBox(height: height * 0.05),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300],
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (_quantity > 1) {
                                          setState(() {
                                            _quantity--;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: Color(0xFFF1523F),
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[300],
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _quantity++;
                                        });
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xFFF1523F),
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.02,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: FlatButton(
                        onPressed: () => addToBasket(),
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
                              "Add to Basket",
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
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}