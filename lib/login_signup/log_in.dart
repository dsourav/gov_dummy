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
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

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
    myFocusNodeName.dispose();
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

            //input field sign up name
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
                  hintText: "Name",
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

             //input field sign up password
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: TextField(
                focusNode: myFocusNodePassword,
                controller: signupPasswordController,
                obscureText: Provider.of<AppState>(context).obscureTextSignup,//calling values of provider
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
                      Provider.of<AppState>(context).obscureTextSignup//calling values of provider
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
                obscureText:
                    Provider.of<AppState>(context).obscureTextSignupConfirm,//calling values of provider
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
                      Provider.of<AppState>(context).obscureTextSignupConfirm//calling values of provider
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
}
