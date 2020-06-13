import 'package:dealjava/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<Store>(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    void scanAndValidate([Map restaurant]) async {
      Map response = await _store.scan(restaurant);
      if (response['valid'] == true) {
        Navigator.pushNamed(context, '/shop-detail');
      } else {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(
               top: Radius.circular(25.0),
             ),
          ),
          enableDrag: true,
          builder: (BuildContext sheetContext){
            return Container(
              height: height * 0.1,
              child: Center(
                child: Text(
                  response['message'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                )
              ),
            );
          }
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/diyo.png',
          height: height * 0.03,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Semua Restoran",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: height * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: _store.restaurants().length,
                itemBuilder: (BuildContext context, int index) {
                  final restaurant = _store.restaurants()[index];
                  return Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () => scanAndValidate(restaurant),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(
                            vertical: height * 0.01, 
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  child: Hero(
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: restaurant['thumbnail'],
                                      width: width * 0.2,
                                      height: width * 0.2,
                                      fit: BoxFit.cover,
                                    ),
                                    tag: restaurant['name'],
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    restaurant['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                  Container(
                                    width: width * 0.6,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          restaurant['address'],
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '=',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text(
                                              restaurant['distance'],
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(width: width * 0.08),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    restaurant['type'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: height * 0.01,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            )
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: width * 0.02,
                            horizontal: height * 0.015,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 14.0,
                              ),
                              SizedBox(width: width * 0.01),
                              Text(
                                restaurant['waiting time'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        backgroundColor: Color(0xFFF1523F),
        onPressed: () => scanAndValidate(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Color(0xFFF1523F),
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xFFF1523F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.watch_later,
                          color: Colors.grey[400],
                        ),
                        Text(
                          'Pesanan',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.grey[400],
                        ),
                        Text(
                          'Favorit',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey[400],
                        ),
                        Text(
                          'Akun',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}