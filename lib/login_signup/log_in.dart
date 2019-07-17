import 'package:design_demo/model.dart';
import 'package:design_demo/navigation_main/home_page_main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'style/theme.dart' as themeas;
import 'utils/bubble_indication_painter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();//full name
  final FocusNode myFocusNodeUserName = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();
  final FocusNode myFocusNodeAddress = FocusNode();


  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupUserNameController = new TextEditingController();//full name
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  TextEditingController signupPhoneController = new TextEditingController();
  TextEditingController signupAddressController = new TextEditingController();

  PageController _pageController;




  //dropdown section intializer

  List<String>itemsRegion=[
                'All of Barishal',
                'Patuakhali',
                'Jhalokati',
                'Bhola',
                'Pirojpur',
                'Barguna',
                
   ];

   List<String>itemsBdAll=[
                'Barishal',
                'Chattogram',
                'Dhaka',
                'Khulna',
                'Mymensingh',
                'Rajshahi',
                'Rangpur',
                'Sylhet'
   ];
  String dropdownvalue = 'Barishal';
  String dropDownvalue2 = 'All of Barishal';

//end of dropdown section







  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    themeas.Colors.loginGradientStart,
                    themeas.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // Padding(
                //   padding: EdgeInsets.only(top: 75.0),
                //   child: new Image(
                //       width: MediaQuery.of(context).size.width/2,
                //       height: MediaQuery.of(context).size.height/6,
                //       fit: BoxFit.fill,
                //       image: new AssetImage('assets/login_logo.png')),
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      final appStateData = Provider.of<AppState>(
                          context); //here appstate initialized
                      if (i == 0) {
                        appStateData.colorLeftReverse(); //here appstate called

                      } else if (i == 1) {
                        appStateData.colorRightReverse(); //here appstate called

                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();//full name
    myFocusNodeAddress.dispose();
    myFocusNodePhone.dispose();
    myFocusNodeUserName.dispose();
    _pageController?.dispose();


    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
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
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                    color: Provider.of<AppState>(context).colorLeft,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                    color: Provider.of<AppState>(context).colorRight,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText:
                              Provider.of<AppState>(context).obscureTextLogin,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _toggleLogin(context);
                              },
                              child: Icon(
                                Provider.of<AppState>(context).obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: themeas.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: themeas.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        themeas.Colors.loginGradientEnd,
                        themeas.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: themeas.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                    onPressed: () {
                      print(loginPasswordController.text.toString());
                      //showInSnackBar("Login button pressed");

                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return new HomePAgeMAin();
                      }));
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0),
                )),
          ),
        ],
      ),
    );
  }

// sign up page entire design
  Widget _buildSignUp(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      controller: new ScrollController(),
      child: new Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: <Widget>[
            //input field sign up full name
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodeName,
                controller: signupNameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                  ),
                  hintText: "Full Name",
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

            //input field sign up user name
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodeUserName,
                controller: signupUserNameController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.black,
                  ),
                  hintText: "User Name",
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),



            

            //input field sign up email
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodeEmail,
                controller: signupEmailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.envelope,
                    color: Colors.black,
                  ),
                  hintText: "Email Address",
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

             //input field sign up phone

Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodePhone,
                controller: signupPhoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.black,
                  ),
                  hintText: "Phone Number",
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

            //input field sign up address
Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodeAddress,
                controller: signupAddressController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.addressBook,
                    color: Colors.black,
                  ),
                  hintText: "Address ",
                  hintStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ),

         
           Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),


            new SizedBox(
              height: 10.0,
            ),
  
      //input field dropdown text
         new Container(child: new Text("Select Division & Region"
         ,style: new TextStyle(
           color: Colors.black87,
           fontSize: 16.0
         ),
         textAlign: TextAlign.start,)),

         //input field dropdown design data
         new Container(
           margin: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new DropdownButton<String>(
              value: dropdownvalue,
              items: itemsBdAll.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    child:new Text(value),
                     value: value);
              }).toList(),
              onChanged: (value) {

                if(value.toString()=='Barishal'){
                  itemsRegion=['All of Barishal','Patuakhali','Jhalokati','Bhola','Pirojpur','Barguna'];
                  dropDownvalue2='All of Barishal';
                }


                if(value.toString()=='Chattogram'){
                  itemsRegion=['All of Chattogram','Agrabad','Nasirabad','Kotwali','Halishahar','Chawkbazar'];
                  dropDownvalue2='All of Chattogram';
                }

                if(value.toString()=='Dhaka'){
                  itemsRegion=['All of Dhaka','Mirpur','Uttara','Dhanmondi','Gulshan','Mohammadpur'];
                  dropDownvalue2='All of Dhaka';
                }

                if(value.toString()=='Khulna'){
                  itemsRegion=['All of Khulna','Khulna Sadar','Sonadanga','Khalishpur','Daulatpur','Rupsa'];
                  dropDownvalue2='All of Khulna';
                }

                if(value.toString()=='Mymensingh'){
                  itemsRegion=['All of Mymensingh','Ganginar par','Chorpara','Town Hall','Valuka','Kewatkhali'];
                  dropDownvalue2='All of Mymensingh';
                }

                if(value.toString()=='Rajshahi'){
                  itemsRegion=['All of Rajshahi','Shaheb Bazar','Shiroil','New Market','Motihar','Uposahar'];
                  dropDownvalue2='All of Rajshahi';
                }

                if(value.toString()=='Rangpur'){
                  itemsRegion=['All of Rangpur','Jahaj Company More','Dhap','Shapla Chottor','Lalbag Mor','Pourobazar'];
                  dropDownvalue2='All of Rangpur';
                }
                
                if(value.toString()=='Sylhet'){
                  itemsRegion=['All of Sylhet','Zinda Bazar','Bandar Bazar','Amber Khana','South Surma','Uposhohor'];
                  dropDownvalue2='All of Sylhet';
                }
                setState(() {
                  dropdownvalue = value;
                });
                print(dropdownvalue);
              },
              
            ),


            new DropdownButton(
              value: dropDownvalue2,
              items: itemsRegion.map<DropdownMenuItem<String>>((String value){

                return new DropdownMenuItem(
                  child: new Text(value),
                  value: value,

                );

              }).toList(),
               onChanged: (value) {
                 setState(() {
                 dropDownvalue2=value;  
                 });
                 print(dropDownvalue2);

               },)
          
            
         
          ],
        ),
      ),


            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

            //input field sign up password
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodePassword,
                controller: signupPasswordController,
                obscureText: Provider.of<AppState>(context)
                    .obscureTextSignup, //calling values of provider
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.lock,
                    color: Colors.black,
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 16.0),
                  suffixIcon: GestureDetector(
                    onTap: () => _toggleSignup(context),
                    child: Icon(
                      Provider.of<AppState>(context)
                              .obscureTextSignup //calling values of provider
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      size: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

            //input field sign up password confirm
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                controller: signupConfirmPasswordController,
                obscureText: Provider.of<AppState>(context)
                    .obscureTextSignupConfirm, //calling values of provider
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    FontAwesomeIcons.lock,
                    color: Colors.black,
                  ),
                  hintText: "Confirmation",
                  hintStyle: TextStyle(fontSize: 16.0),
                  suffixIcon: GestureDetector(
                    onTap: () => _toggleSignupConfirm(context),
                    child: Icon(
                      Provider.of<AppState>(context)
                              .obscureTextSignupConfirm //calling values of provider
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      size: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[400],
            ),

            //button design of sign up
            Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: themeas.Colors.loginGradientStart,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                  BoxShadow(
                    color: themeas.Colors.loginGradientEnd,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: new LinearGradient(
                    colors: [
                      themeas.Colors.loginGradientEnd,
                      themeas.Colors.loginGradientStart
                    ],
                    begin: const FractionalOffset(0.2, 0.2),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: themeas.Colors.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                  onPressed: () => showInSnackBar("SignUp button pressed")),
            )
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin(BuildContext context) {
    final apstateData = Provider.of<AppState>(context);
    apstateData.obSecureLogin();
    print(apstateData.obscureTextLogin.toString());
  }

  void _toggleSignup(BuildContext context) {
    final apstateData = Provider.of<AppState>(context);
    apstateData.obsecureSignup();
  }

  void _toggleSignupConfirm(BuildContext context) {
    final apstateData = Provider.of<AppState>(context);
    apstateData.obsecureSignupConfirm();
  }


//drop down part design data
  Widget _dropDownSection(){
      
  }
}
