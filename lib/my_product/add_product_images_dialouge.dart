import 'dart:io';
import 'dart:io' as prefix0;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddProductImages extends StatefulWidget {
  var productId;
  AddProductImages({this.productId});
  @override
  _AddProductImagesState createState() => _AddProductImagesState();
}

class _AddProductImagesState extends State<AddProductImages> {
  var _file1, _file2, _file3;
  List<File> _files = new List();
  Map<String, String> filesPaths;
  bool _loaderState=false;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    
        return ModalProgressHUD(
            inAsyncCall: _loaderState,
            dismissible: false,
            child: new SimpleDialog(
            
            title: new Text("Select Images Max:3"),
            children: <Widget>[
              Container(
                height: 100.0,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: new Container(
                        padding: EdgeInsets.all(2.0),
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.black)),
                        child: new GestureDetector(
                          child: _file1 != null && _file1.path.isNotEmpty
                              ? Image.file(
                                  _file1,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                )
                              : Image.asset(
                                  'assets/person.png',
                                  fit: BoxFit.fill,
                                ),
                          onTap: () {
                            getImage1();
                            if (_file1 != null) {
                              _files.add(_file1);
                            }
                          },
                        ),
                      ),
                    ),
                    new Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: new Container(
                        padding: EdgeInsets.all(2.0),
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.black)),
                        child: new GestureDetector(
                          child: _file2 != null && _file2.path.isNotEmpty
                              ? Image.file(
                                  _file2,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                )
                              : Image.asset(
                                  'assets/person.png',
                                  fit: BoxFit.fill,
                                ),
                          onTap: () {
                            getImage2();
                            // if(_file2!=null){
                            //   _files.add(_file2);
                            // }
                          },
                        ),
                      ),
                    ),
                    new Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: new Container(
                        padding: EdgeInsets.all(2.0),
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.black)),
                        child: new GestureDetector(
                          child: _file3 != null && _file3.path.isNotEmpty
                              ? Image.file(
                                  _file3,
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.medium,
                                )
                              : Image.asset(
                                  'assets/person.png',
                                  fit: BoxFit.fill,
                                ),
                          onTap: () {
                            getImage3();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Mutation(
                  builder: (RunMutation runMutation, QueryResult result) {
                    return new MaterialButton(
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "Submit Image",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      onPressed: () async {

                        
                        // print( _files.toString());
                        if (_file1 != null && _file1.path.isNotEmpty ||
                            _file2 != null && _file2.path.isNotEmpty ||
                            _file3 != null && _file3.path.isNotEmpty) {
                            setState(() {
                              _loaderState=true;
                            });
                          runMutation({
                            'id': widget.productId,
                            'images': [
                              _file1 ?? null,
                              _file2 ?? null,
                              _file3 ?? null
                            ]
                          });
                        } else {
                          setState(() {
                            _loaderState=false;
                          });
                          _showInSnackBar("Please Add images");
                        
                        }

                        // Map<String,String> filesPaths;
                        // filesPaths = await FilePicker.getMultiFilePath(type: FileType.IMAGE).then((onValue){
                        //   print(onValue.length);

                        // });
                        //   await FilePicker.getFile(type: FileType.IMAGE).then((onValue){
                        //     print("file added");
                        //     runMutation({
                        //   'image':onValue

                        // });

                        //   });

                        //   ByteData byteData = await asset.requestOriginal();
                        //  var data=byteData.buffer.asUint8List();
                        //   print(data.toString());
                        // MultipartFile multipartFile = MultipartFile.fromBytes(
                        //   'photo',
                        //   data,
                        //   filename: asset.name,
                        //   contentType: MediaType("image", "jpg"),
                        // );
                      },
                    );
                  },
                  options: MutationOptions(
                      document: globals.addProductImagesQuery, variables: {}),
                  update: (Cache cache, QueryResult result) {
                    if (result.hasErrors) {
                       setState(() {
                              _loaderState = false;
                            });
                      //print(widget.productId.toString());
                      print(result.errors.toString());
                      _showInSnackBar(result.errors.toString());
                    } else if (result.data != null) {
                       setState(() {
                              _loaderState = false;
                            });
                      _showInSnackBar("Successfully Added Your Product");
                      Navigator.of(context).pop();
                    } else {
                      print("error");
                    }
                  })
            ]), 
      );
    
  }

  Future getImage1() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _file1 = image;
    });
  }

  Future getImage2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _file2 = image;
    });
  }

  Future getImage3() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _file3 = image;
    });
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
  // setFilesData(){
  //   _file1!=null?_files.add(_file1):_files.remove(_file1);
  //   _file2!=null?_files.add(_file2):_files.remove(_file2);
  //   _file3!=null?_files.add(_file3):_files.remove(_file3);
  // }

}
