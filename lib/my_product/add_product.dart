import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  bool _loaderState = false;

  var _polIntervalGetter = null;
  //final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Add Product"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loaderState,
        dismissible: false,
        progressIndicator: new CircularProgressIndicator(),
        child: new Container(
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
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
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
                         DropdownButtonHideUnderline(
                                                  child: ButtonTheme(
                                                    alignedDropdown: true,
                                                             child: new DropdownButton(
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
                                                  ),
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
                                  ),
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
                                  ),
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
                                ),
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
                                ),
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
                            ),
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
                        if (_productdesCription.text.isNotEmpty &&
                            _productmaxQtyController.text.isNotEmpty &&
                            _productminQtyController.text.isNotEmpty &&
                            _productPriceController.text.isNotEmpty &&
                            _productPriceExtensionController.text.isNotEmpty &&
                            _mySelection.isNotEmpty) {
                          //print("ok btn call");
                          setState(() {
                            _loaderState = true;
                          });
                          runMutation({
                            'name': _dropdownProductsNamevalue,
                            'min_quantity':
                                int.parse(_productminQtyController.text),
                            'min_quantity_extension': dropdownQtyExtension,
                            'quantity':
                                int.parse(_productmaxQtyController.text),
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
                        //   if (_productdesCription.text==null||_productmaxQtyController.text==null||
                        //  _productminQtyController.text==null|| _productPriceController.text==null||
                        //  _productPriceController.text==null||_mySelection==null) {

                        //   }
                        else {
                          Flushbar(
                            message: "not valid",
                          )..show(context);
                          // setState(() {

                          // });
                        }
                      },
                    );
                  },
                  options: MutationOptions(document: globals.addProductQeury),
                  update: (Cache cache, QueryResult result) async {
                    if (result.hasErrors) {
                      //print(result.errors.toString());
                      setState(() {
                        _loaderState = false;
                      });
                      _showInSnackBar(result.errors.toString());
                    } else if (result.data != null) {
                      setState(() {
                        _loaderState = false;
                        _productmaxQtyController.clear();
                        _productmaxQtyController.clear();
                        _productPriceController.clear();
                        _productPriceExtensionController.clear();
                        _productdesCription.clear();
                      });
                      //Navigator.of(context).pop();

                      var resultReturn = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AddProductImages(
                                productId: result.data['addProduct']['id'],
                              ));
                      // print(resultReturn.toString());
                      // showDialog(
                      //     context: context,
                      //     builder: (_) => new AddProductImages(

                      //         ),
                      //     );
                      //print();
                      if (resultReturn == true) {
                        // Flushbar(message: "Product added",duration: Duration(seconds: 1),)..show(context);
                        Navigator.of(context).pop(true);
                      }
                    } else {
                      setState(() {
                        _loaderState = false;
                      });
                      _showInSnackBar("something wrong");
                      // print("error");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
