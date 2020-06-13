import 'package:dealjava/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ShopDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store _store = Provider.of<Store>(context);
    final double navBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Map restaurant = _store.restaurant();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: navBarHeight),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Hero(
                      child: Image.network(
                        restaurant['thumbnail'],
                        height: height * 0.25,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                      tag: restaurant['name'],
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
                    Positioned(
                      bottom: height * 0.02,
                      left: width * 0.04,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Color(0xFFF1523F),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.store,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Text(
                              "No. Meja ${_store.tableNumber()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.02,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant['name'],
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        restaurant['type'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        restaurant['address'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Divider(
                        height: 1.0,
                        thickness: 1.0
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Color(0xFFF1523F),
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                'BUKA',
                                style: TextStyle(
                                  color: Color(0xFFF1523F),
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                'until 19.00 today',
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              color: Color(0xFFF1523F),
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.place,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  restaurant['distance'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.02,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _store.getCategories().map((category) {
                      return InkWell(
                        onTap: () => _store.setCategory(category),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: category == _store.activeCategory()
                              ? Color(0xFFF1523F) : Colors.white,
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: category == _store.activeCategory()
                              ? Colors.white : Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.02,
                    ),
                    child: Column(
                      children: _store.getItems().map((item) {
                        Map<String, Map> options = { 'item': item };
                        return InkWell(
                          onTap: () => Navigator.pushNamed(context, '/item-detail', arguments: options),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    child: Hero(
                                      tag: item['name'],
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: item['thumbnail'],
                                        width: width * 0.15,
                                        height: width * 0.15,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          item['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        Text(
                                          _store.formatPrice(item['price']),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                ),
                                child: Divider(
                                  height: 1.0,
                                  thickness: 0.5,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
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
                  onPressed: () => Navigator.pushNamed(context, '/basket'),
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
                        "View Basket",
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
    );
  }
}