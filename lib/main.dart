// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smart_pay/providers/user_provider.dart';
import 'package:smart_pay/views/authentication/create_pin_screen.dart';
import 'package:smart_pay/views/authentication/signup_screen.dart';
import 'package:smart_pay/views/splashScreen.dart';
// Import helper classes and widgets
import 'helpers/colors.dart';
import 'helpers/dialog_helper/dialog_handler.dart';
import 'helpers/routes.dart';
// Import screens/views
import 'views/onboarding_view.dart';

// Initialize GetIt, the service locator for dependency injection
final GetIt locator = GetIt.instance;

// Sets up the service locator and registers services and view models
void setupLocator() {
  // Register a singleton instance of DialogHandler for global access
  locator.registerLazySingleton<DialogHandler>(() => DialogHandler());
  // Register other services or view models as needed here
}

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  setupLocator(); // Set up GetIt locator
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // Preserve native splash screen

  // Remove the splash screen after a delay (e.g., to wait for initial data loading)
  Future.delayed(const Duration(seconds: 5)).then((value) {
    FlutterNativeSplash.remove(); // Remove splash screen when initialization is complete
  });

  // Get and print the device name asynchronously

  runApp(

      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=> UserProvider())
          ],
          child: const MyApp()
      )); // Run the app

}

// Gets the device name and prints it based on the OS (Android, iOS, or Linux)


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Future<dynamic> getDeviceName() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String ?infoDevice;


    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addObserver(this);
    }

    @override
    void dispose() {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    }


    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      super.didChangeAppLifecycleState(state);
      if (state == AppLifecycleState.resumed) {
        // Push the PIN screen over the current screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CreatePinScreen(AppState: 'resumed',)),
              (Route<dynamic> route) => false,
        );
      }
    }


    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      infoDevice = androidInfo.model;
      print("Android device model: ${androidInfo.model}");
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      infoDevice = iosInfo.name;
      print("iOS device name: ${iosInfo.name}");
    } else if (Platform.isLinux) {
      final LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      infoDevice = linuxInfo.name;
      print("Linux device name: ${linuxInfo.name}");
    } else {
      print("Unsupported platform.");
    }
    print('info la n fi foooo $infoDevice');

    return infoDevice;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      final  deviceInfo = await getDeviceName();
      print('>>>>>>>>>>>. testsssing device name methof${deviceInfo} ooooorrrrrr ${deviceInfo}');
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setDeviceName('${deviceInfo}');
    },);

  }


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary, // Use custom color from AppColors
        ),
        fontFamily: 'SFProDisplay', // Set the default font family
      ),
      home:  SplashScreen(), // Set the initial route
      onGenerateRoute: RouteHelper().generateRoute, // Handle named route generation
    );
  }
}
