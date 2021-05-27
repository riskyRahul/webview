import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Utils/constant.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:location/location.dart';
// import 'package:share/share.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:package_info/package_info.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:permission_handler/permission_handler.dart';

WebViewController _controller;
bool _loading = true;
int _currentSelected = 0;
bool isInternet = false;

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  // var location = Location();

  bool _openMenuFromRightToLeft = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _loadMenuInfo();

    _checkInternet();

    //launch("https://i.postimg.cc/D2yckdkB/banner.jpg?dl=1");
    //launch("https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3");
    //launch("https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf");

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        setState(() {
          isInternet = true;
        });
      } else if (result == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        setState(() {
          isInternet = true;
        });
      } else {
        setState(() {
          isInternet = false;
        });
      }
    });

    // _checkStoragePermission();
  }

  // _checkStoragePermission() async {
  //   //Map<PermissionGroup, PermissionStatus> permissions =
  //   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  // }

  // _showMyToast(String str) {
  //   Fluttertoast.showToast(
  //     msg: "" + str,
  //     toastLength: Toast.LENGTH_SHORT,
  //     //gravity: ToastGravity.BOTTOM,
  //     timeInSecForIos: 1,
  //     backgroundColor: Constant.lightTheme.primaryColor,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }

  _checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      setState(() {
        isInternet = true;
      });
      print("I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      setState(() {
        isInternet = true;
      });
      print("I am connected to a wifi network.");
    } else {
      setState(() {
        isInternet = false;
      });
      print("No internet connection!");
    }

    /*try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isInternet = true;
          });
        }
      } on SocketException catch (_) {
        setState(() {
          isInternet = false;
        });

      }*/

    //_showMyToast(""+isInternet.toString());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // _loadMenuInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     if (prefs.getBool(openMenuFromRightToLeft) == null) {
  //       _openMenuFromRightToLeft = false;
  //     } else {
  //       _openMenuFromRightToLeft = prefs.getBool(openMenuFromRightToLeft);
  //     }
  //   });
  // }

  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.black);

  static final List<String> _listViewData = [
    "Home",
    "Support",
    "Our Products",
    "About Us",
    "Contact Us",
    "Privacy Policy",
    "Ad",
    "Settings",
    "Share",
  ];

  static final List<String> _listViewDataAction = [
    "/",
    // SupportScreen.routeName,
    // OurProductsScreen.routeName,
    // AboutUsScreen.routeName,
    // ContactUsScreen.routeName,
    // PrivacyPolicyScreen.routeName,
    // AdScreen.routeName,
    // SettingsScreen.routeName,
    // SettingsScreen.routeName,
  ];

  static final List<IconData> _listViewDataIcon = [
    Icons.home,
    Icons.headset_mic,
    Icons.list,
    Icons.account_box,
    Icons.phone,
    Icons.vpn_key,
    Icons.add,
    Icons.settings,
    Icons.share,
  ];

  SizedBox getNavDrawer(BuildContext context) {
    return new SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: DrawerHeader(
                    margin: new EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Constant.lightTheme.primaryColor,
                      /*image: DecorationImage(
                      image: AssetImage("assets/menu_header.png"),
                      fit: BoxFit.cover,
                    )*/
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //CircularProgressIndicator(),
                          SizedBox(height: 10.0),
                          /*FlutterLogo(
                      size: 50.0,
                      //colors: Colors.blue,
                    ),*/
                          Image(
                            image: AssetImage("assets/app_logo.png"),
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "OSHO",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  padding: new EdgeInsets.all(0),
                  //padding: EdgeInsets.all(10.0),
                  itemCount: _listViewData.length,
                  separatorBuilder: (context, index) => Divider(
                    color:
                        index == 2 || index == 5 ? Colors.black : Colors.white,
                    thickness: index == 2 || index == 5 ? 0.2 : 0,
                    height: index == 2 || index == 5 ? 0.2 : 0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: _currentSelected == index
                          ? Colors.transparent
                          : Colors.transparent, //black12
                      padding: new EdgeInsets.all(0),
                      child: ListTile(
                        leading: Icon(_listViewDataIcon[index]),
                        title: Text(_listViewData[index]),
                        onTap: () {
                          setState(() {
                            _currentSelected = index;

                            // pop closes the drawer
                            Navigator.of(context).pop();

                            if (index == 8) {
                              // _shareApp();
                            } else if (index != 0) {
                              // navigate to the route
                              Navigator.of(context)
                                  .pushNamed(_listViewDataAction[index])
                                  .then((flag) {
                                if (flag) {
                                  print("back execution");
                                  // _loadMenuInfo();
                                  // you're back from PageB, perform your function here
                                  setState(
                                      () {}); // you may need to call this if you want to update UI
                                }
                              });
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  SizedBox getRightNavDrawer(BuildContext context) {
    return new SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: DrawerHeader(
                    margin: new EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Constant.lightTheme.primaryColor,
                      /*image: DecorationImage(
                      image: AssetImage("assets/menu_header.png"),
                      fit: BoxFit.cover,
                    )*/
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //CircularProgressIndicator(),
                          SizedBox(height: 10.0),
                          /*FlutterLogo(
                        size: 50.0,
                        //colors: Colors.blue,
                      ),
                      SizedBox(height: 25.0),*/
                          Image(
                            image: AssetImage("assets/app_logo.png"),
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "OSHO",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.separated(
                  padding: new EdgeInsets.all(0),
                  //padding: EdgeInsets.all(10.0),
                  itemCount: _listViewData.length,
                  separatorBuilder: (context, index) => Divider(
                    color:
                        index == 2 || index == 5 ? Colors.black : Colors.white,
                    thickness: index == 2 || index == 5 ? 0.2 : 0,
                    height: index == 2 || index == 5 ? 0.2 : 0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: _currentSelected == index
                          ? Colors.transparent
                          : Colors.transparent, //black12
                      padding: new EdgeInsets.all(0),
                      child: ListTile(
                        trailing: Icon(_listViewDataIcon[index]),
                        title: Text(
                          _listViewData[index],
                          textAlign: TextAlign.end,
                        ),
                        onTap: () {
                          setState(() {
                            _currentSelected = index;

                            // pop closes the drawer
                            Navigator.of(context).pop();

                            if (index == 8) {
                              // _shareApp();
                            } else if (index != 0) {
                              // navigate to the route
                              Navigator.of(context)
                                  .pushNamed(_listViewDataAction[index])
                                  .then((flag) {
                                if (flag) {
                                  print("back execution");
                                  // _loadMenuInfo();
                                  // you're back from PageB, perform your function here
                                  setState(
                                      () {}); // you may need to call this if you want to update UI
                                }
                              });
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  // _shareApp() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;

  //   Share.share(
  //       'Check out my $appName application https://play.google.com/store/apps/details?id=$packageName');
  // }

  @override
  Widget build(BuildContext context) {
    //_loadHtmlFromAssets();

    return WillPopScope(
        onWillPop: () => _exitApp(context),
        child: SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   title: Text("Home"),
            //   /*actions: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.share),
            //       onPressed: () {
            //         _shareApp();
            //       },
            //     ),
            //   ],*/
            // ),
            body: Builder(builder: (BuildContext context) {
              return WebView(
                // to load web page url
                initialUrl: 'https://osho.hyperthinksys.in/',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  //load HTML file from Assets
                  // _loadHtmlFromAssets();
                  //print("onWebViewCreated");
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains("mailto:") ||
                      request.url.contains("tel:") ||
                      request.url.contains("sms:")) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }

                  _checkInternet();

                  print("isInternet : " + isInternet.toString());

                  if (!isInternet) {
                    // _showMyToast("No internet connection!");
                    return NavigationDecision.prevent;
                  }

                  if (request.url.contains("geo:")) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }

                  if (request.url.contains('youtube')) {
                    print('blocking navigation to $request}');
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }

                  if (request.url.startsWith(
                      "https://play.google.com/store/apps/details?id=")) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }

                  if (request.url.contains('target=blank')) {
                    launch(request.url, forceSafariVC: false);
                    return NavigationDecision.prevent;
                  }

                  // if (request.url.contains("https://browserleaks.com/geo")) {
                  //   locationService();
                  // }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  setState(() {
                    _loading = true;
                  });
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    _loading = false;
                  });
                },
                gestureNavigationEnabled: true,
              );
            }),
            // drawer: _openMenuFromRightToLeft?null:getNavDrawer(context),
            // endDrawer: _openMenuFromRightToLeft?getNavDrawer(context):null,
          ),
        ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("didChangeAppLifecycleState : $state");

    if (state == AppLifecycleState.resumed) {
      print("resumed");
      // _loadMenuInfo();
    } else if (state == AppLifecycleState.inactive) {
      print("inactive");
    } else if (state == AppLifecycleState.paused) {
      print("paused");
    } else if (state == AppLifecycleState.detached) {
      print("detached");
    }
  }

  // locationService() {
  //   location.requestPermission().then((granted) {
  //     // if (granted) {}
  //   });
  // }

  Future<bool> _exitApp(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    } else {
      return Future.value(true);
    }
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/index.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
