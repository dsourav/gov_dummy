import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'add_product_images_dialouge.dart';

class AddNEwProduct extends StatefulWidget {
  @override
  _AddNEwProductState createState() => _AddNEwProductState();
}

class _AddNEwProductState extends State<AddNEwProduct> {
  GraphQLClient client;
  initMethod(context) {
    client = GraphQLProvider.of(context).value;
  }

// static String assetUser = 'assets/user.svg';
// final Widget svg = new SvgPicture.asset(
//   assetUser,
//   semanticsLabel: 'Acme Logo'
// );

  bool isAvailable = true;
  bool isRetailable = true;

  Map<String, String> filesPaths;
  String _fileName;
  String filePath;
  

  List<String> _productNames = [
    'Cakes',
    'Biscuits',
    'Beverages',
    'Soft drinks',
    'Egg products',
    'Frozen foods',
    'Meats',
    'Oils, butters',
    'Vegetables'
  ];
  List<String> _productqtyExtension = [
    'gram',
    'kg',
    'pcs',
    'liter',
    'pkts',
  ];

  String _dropdownProductsNamevalue = 'Vegetables';
  String dropdownQtyExtension = "kg";
  String dropdownQtyPriceExtension = "kg";
  TextEditingController _productmaxQtyController = new TextEditingController();
  TextEditingController _productminQtyController = new TextEditingController();
  TextEditingController _productdesCription = new TextEditingController();
  TextEditingController _productPriceController = new TextEditingController();
  TextEditingController _productPriceExtensionController =
      new TextEditingController();

  String _mySelection;
  List<dynamic> _myJson;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Add Product"),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Query(
              builder: (QueryResult result, {VoidCallback refetch}) {
                if (result.errors != null) {
                  return Text(result.errors.toString());
                }

                if (result.loading) {
                  return Text('Loading');
                }
                _myJson = result.data['categories'];

                return Card(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: new DropdownButton<String>(
                      isDense: true,
                      hint: new Text("Select Product Categories"),
                      value: _mySelection,
                      onChanged: (String newValue) {
                        setState(() {
                          _mySelection = newValue;
                          //print(_mySelection);
                        });

                        //print(_mySelection);
                      },
                      items: _myJson.map((map) {
                        return new DropdownMenuItem<String>(
                          value: map['id'].toString(),
                          child: new Text(
                            map['name'],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
              options: QueryOptions(document: globals.categoriesNameQuery),
            ),
            new Container(
              child: new Text("Select Product Name"),
            ),
            new Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  child: new Column(
                    children: <Widget>[
                      new DropdownButton(
                        value: _dropdownProductsNamevalue,
                        items: _productNames
                            .map<DropdownMenuItem<String>>((String value) {
                          return new DropdownMenuItem(
                            child: new Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _dropdownProductsNamevalue = value;
                          });
                        },
                      ),
                      Card(
                        child: new Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "maximum Qty",
                                    hintStyle: TextStyle(fontSize: 17.0),
                                    errorText: validateProduct(
                                        _productmaxQtyController.text)),
                                keyboardType: TextInputType.number,
                                controller: _productmaxQtyController,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "miniimum Qty",
                                    hintStyle: TextStyle(fontSize: 17.0),
                                    errorText: validateProduct(
                                        _productmaxQtyController.text)),
                                keyboardType: TextInputType.number,
                                controller: _productminQtyController,
                              ),
                            )
                          ],
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              child: new Text("Enter quantity type"),
                            ),
                          ),
                          new Flexible(
                            child: new DropdownButton(
                              value: dropdownQtyExtension,
                              items: _productqtyExtension
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return new DropdownMenuItem(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownQtyExtension = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter price",
                                  hintStyle: TextStyle(fontSize: 17.0),
                                  errorText: validateProduct(
                                      _productmaxQtyController.text)),
                              keyboardType: TextInputType.number,
                              controller: _productPriceController,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter price extension",
                                  hintStyle: TextStyle(fontSize: 17.0),
                                  errorText: validateProduct(
                                      _productmaxQtyController.text)),
                              keyboardType: TextInputType.number,
                              controller: _productPriceExtensionController,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: new DropdownButton(
                              value: dropdownQtyPriceExtension,
                              items: _productqtyExtension
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return new DropdownMenuItem(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownQtyPriceExtension = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(8.0),
                        // hack textfield height
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: TextField(
                          maxLines: 10,
                          decoration: InputDecoration(
                              hintText: "Descrption!",
                              border: OutlineInputBorder(),
                              errorText:
                                  validateProduct(_productdesCription.text)),
                          controller: _productdesCription,
                        ),
                      ),
                    ],
                  ),
                )),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: new Text("select Available or not"),
                ),
                Switch(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: new Text("select Retailable or not"),
                ),
                Switch(
                  value: isRetailable,
                  onChanged: (value) {
                    setState(() {
                      isRetailable = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            Mutation(
                builder: (RunMutation runMutation, QueryResult result) {
                  return new MaterialButton(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    onPressed: () async {
                      // ByteData byteData = await asset.requestOriginal();
                      // List<int> imageData = byteData.buffer.asUint8List();
                      // print(imageData.toString());
                      // print(byteData.buffer.toString());

                      if (_productdesCription.text.length > 0 &&
                          _productmaxQtyController.text.length > 0 &&
                          _productminQtyController.text.length > 0 &&
                          _productPriceController.text.length > 0 &&
                          _productPriceExtensionController.text.length > 0) {
                        print("ok btn call");
                        runMutation({
                          'name': _dropdownProductsNamevalue,
                          'min_quantity':
                              int.parse(_productminQtyController.text),
                          'min_quantity_extension': dropdownQtyExtension,
                          'quantity': int.parse(_productmaxQtyController.text),
                          'quantity_extension': dropdownQtyExtension,
                          'price': double.parse(_productPriceController.text),
                          'price_extension':
                              "${_productPriceExtensionController.text} ${dropdownQtyPriceExtension.toString()}",
                          'available_now': isAvailable,
                          'retailable': isRetailable,
                          'description': _productdesCription.text,
                          'gov_price': 120.0,
                          'gov_price_extension': "12pcs",
                          'categoryId': _mySelection
                        });
                      }
                    },
                  );
                },
                options: MutationOptions(document: globals.addProductQeury),
                update: (Cache cache, QueryResult result) {
                  if (result.hasErrors) {
                    print(result.errors.toString());
                  } else if (result.data != null) {
                    // showDialog(context: context,
                    // builder: (_)=>new AddProductImages(),
                    // barrierDismissible: false
                    // );
                    print(result.data['addProduct']['user']['id']);
                  } else {
                    print("error");
                  }
                }),

          ],
        ),
      ),
    );
  }

 



  String validateProduct(String value) {
    if (value.isNotEmpty) {
      return "Please enter something";
    }
    return null;
  }
}
