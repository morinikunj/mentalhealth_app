import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mentalhealth_app/experts/presentation/register.dart';
import 'package:mentalhealth_app/user/authentication/login/presentation/login_screen.dart';
import 'package:mentalhealth_app/user/authentication/register/register_screen.dart';
import 'package:mentalhealth_app/user/splash_screen/presentation/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class EmotionDetection extends StatefulWidget {
//   EmotionDetection({super.key});

//   @override
//   State<EmotionDetection> createState() => _EmotionDetectionState();
// }

// class _EmotionDetectionState extends State<EmotionDetection> {
//   CameraImage? cameraImage;
//   CameraController? cameraController;
//   String output = 'tarun';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadCamera();
//     loadModel();
    
//   }

//   loadCamera() {
//     cameraController = CameraController(cameras![1], ResolutionPreset.medium);
//     cameraController!.initialize().then((value) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {
//           cameraController!.startImageStream((imageStream) {
//             cameraImage = imageStream;
//             runModel();
//           });
//         });
//       }
//     });
//   }

//   runModel() async {
//     if (cameraImage != null) {
//       var predictions = await Tflite.runModelOnFrame(
//         bytesList: cameraImage!.planes.map((plane) {
//           return plane.bytes;
//         }).toList(),
//         imageHeight: cameraImage!.height,
//         imageWidth: cameraImage!.width,
//         imageMean: 127.5,
//         imageStd: 127.5,
//         rotation: 90,
//         numResults: 2,
//         threshold: 0.1,
//         asynch: true,
//       );

//       predictions!.forEach((element) {
//         setState(() {
//           output = element['label'];
//         });
//       });
//     }
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//         model: 'assets/model/model.tflite', labels: 'assets/model/labels.txt');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mentalBrandLightColor,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.mentalBrandColor,

//         title: AppBarTitle(
//           title: 'Live Emotion Detection',
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.7,
//               width: MediaQuery.of(context).size.width,
//               child: !cameraController!.value.isInitialized
//                   ? Container()
//                   : AspectRatio(
//                       aspectRatio: cameraController!.value.aspectRatio,
//                       child: CameraPreview(cameraController!),
//                     ),
//             ),
//           ),
//           Text(
//             output,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
