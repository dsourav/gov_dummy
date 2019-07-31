import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:design_demo/global_variable/global query.dart' as globals;

class AddProductImages extends StatefulWidget {
  @override
  _AddProductImagesState createState() => _AddProductImagesState();
}

class _AddProductImagesState extends State<AddProductImages> {

  File _file1, _file2, _file3;
  @override
  Widget build(BuildContext context) {
      return new SimpleDialog(
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
                      child: _file1!=null&&_file1.path.isNotEmpty?
                      Image.file(_file1,fit: BoxFit.fill,filterQuality: FilterQuality.medium,):
                      Image.asset('assets/person.png',fit: BoxFit.fill,) ,
                      onTap: (){
                        getImage1();
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
                      child: _file2!=null&&_file2.path.isNotEmpty?
                      Image.file(_file2,fit: BoxFit.fill,filterQuality: FilterQuality.medium,):
                      Image.asset('assets/person.png',fit: BoxFit.fill,) ,
                      onTap: (){
                        getImage2();
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
                      child: _file3!=null&&_file3.path.isNotEmpty?
                      Image.file(_file3,fit: BoxFit.fill,filterQuality: FilterQuality.medium,):
                      Image.asset('assets/person.png',fit: BoxFit.fill,) ,
                      onTap: (){
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
                      // showDialog(
                          // context: context,
                          // builder: (_) => );

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
                    print(result.errors.toString());
                  } else if (result.data != null) {
                    print(result.data.toString());
                  } else {
                    print("error");
                  }
                })

        ]);
  }

    Future getImage1() async {
    var image=await ImagePicker.pickImage(source: ImageSource.gallery);
   
    setState(() {
      _file1=image;
    });

   
  }

  Future getImage2() async {
     var image=await ImagePicker.pickImage(source: ImageSource.gallery);
   
    setState(() {
      _file2=image;
    });
    
  }

  Future getImage3() async {
      var image=await ImagePicker.pickImage(source: ImageSource.gallery);
   
    setState(() {
      _file3=image;
    });
    
  }
   
}