import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import '../Const.dart';
import '../function.dart';
// import 'package:image/image.dart' as img;

class ScannerFrame extends StatefulWidget {
  const ScannerFrame({super.key});

  @override
  State<ScannerFrame> createState() => _ScannerFrameState();
}

class _ScannerFrameState extends State<ScannerFrame> {
  late CameraController _cameraController;
  late String message;
  late String predictionLabel;
  late String predictionConfidence;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    message="Loading...";
    predictionLabel='';
    predictionConfidence='';
    _cameraController= CameraController(cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((value){
      setState(() {
        if(!mounted){
          message="Cant connect to the camera";
        }
      });
    });
    LoadModel();
  }
  LoadModel() async{
    await Tflite.loadModel(
      model: 'Models/model.tflite',
      labels:'Models/labels.txt' 
    );
    
  // Get the input shape
      final inputShape = Tflite.anchors;

      // Print the input shape
      print('Input Shape: $inputShape');
    print("****************************load secc********************");
  }

  Predict(File image) async{

    // var recognitions = await Tflite.runModelOnBinary(
    //   binary: imageToByteListFloat32(img.decodeImage(image.readAsBytesSync()), 224, 127.5, 127.5),
    //   numResults: 2,    // defaults to 5
    //   threshold: 0.05,  // defaults to 0.1
    //   asynch: true      // defaults to true
    // );
    // setState(() {
    //   prediction=recognitions![0]['label'].toString();
    // });
    try{
         var result= await Tflite.runModelOnImage(
          path: image.path,
          numResults: 2,
          threshold: 0.0,
          imageMean: 127.5,
          imageStd: 127.5
          );
          print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&$result');
          setState(() {
            if(result![0]['confidence']>0.5){
              predictionLabel=result![0]['label'].toString();
              predictionConfidence=(result![0]['confidence']*100).toStringAsFixed(1);
            }else{
              predictionLabel='Unknown';
              predictionConfidence='Unknown';              
            }
          }); 
    }catch(e){
      print('***************************************');
      print(e.toString());
      print('***************************************');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       _cameraController.cameraId==-1 ? Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: GestureDetector(
            child: Text("",style: TextStyle(color: Colors.white),),
            ),
        ),
      )
      :
      Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CameraPreview(_cameraController),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,color: Colors.white70,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Hero(tag: 'logo',child: Image.asset("images/logo.png",height: 45,)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: primaryColor.withOpacity(0.6),
                  radius: 35,
                  child: IconButton(
                    icon: ImageIcon(AssetImage('images/scan.png'),color: Colors.white,size: 30,),
                    onPressed: () async {
                      if(!_cameraController.value.isInitialized){
                        return null;
                      }
                      if(_cameraController.value.isTakingPicture){
                        return null;
                      }
                      try{
                        await _cameraController.setFlashMode(FlashMode.auto);
                        XFile picture= await _cameraController.takePicture();
                        File resizedImage= await resizeImage(picture.path);
                        await Predict(File(resizedImage.path));
                        // ignore: use_build_context_synchronously
                        showDialog(
                                    context: context,
                                    builder: (context){
                                      printImageShape(picture.path);
                                      
                                      return AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content:GestureDetector(
                                          onDoubleTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          height: MediaQuery.of(context).size.height*0.7,
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  bottom: 0,
                                                  child: Image.file(File(picture.path),height: MediaQuery.of(context).size.height*0.7,width: MediaQuery.of(context).size.width*0.67,)),
                                                Positioned(
                                                  top: 0,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('confidence: $predictionConfidence %',style: TextStyle(color: Colors.white),),
                                                      SizedBox(height: 10,),
                                                      Text('label: $predictionLabel',style: TextStyle(color: Colors.white),),
                                                    ],
                                                  )
                                                  ),
                                              ],
                                            ),
                                          )
                                          ),
                                        ),
                                      );
                                  }
                            );
                      }catch(e){
                        print('*********************************************error***************************************');
                        print(e);
                      }
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}