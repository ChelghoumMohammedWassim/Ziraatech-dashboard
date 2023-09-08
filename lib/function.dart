import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart';
import 'dart:typed_data';

void printImageShape(String imagePath) {
  final imageFile = File(imagePath);
  final image = decodeImage(imageFile.readAsBytesSync());
  final width = image?.width;
  final height = image?.height;
  final bytesPerPixel = image?.numberOfChannels;

  final pixelValue = image?.getPixel(0, 0);
  final dtype = pixelValue.runtimeType.toString();

  print('**************************************************Image shape: $height x $width x $bytesPerPixel**************************************************');
  print('Pixel dtype: $dtype');
}

Future<File> resizeImage(String imagePath) async {
  final imageFile = File(imagePath);
  final image = decodeImage(imageFile.readAsBytesSync());

  final newWidth = 224;
  final newHeight = 224;

  final resizedImage = copyResize(image!, width: newWidth, height: newHeight);
  
  final rotatedImage = copyRotate(resizedImage, 90);
  File rotatedImageFile = await saveImageToFile(rotatedImage);
  
  return rotatedImageFile;
}


Future<File> saveImageToFile(Image rotatedImage) async {
  final directory = await getTemporaryDirectory();
  
  final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
  
  final filePath = '${directory.path}/$fileName';
  
  final File file = File(filePath);
  await file.writeAsBytes(encodeJpg(rotatedImage));
  
  return file;
}

Uint8List imageToByteListFloat32(Image? image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image!.getPixel(j, i);
      buffer[pixelIndex++] = (getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}

Uint8List imageToByteListUint8(Image? image, int inputSize) {
  var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
  var buffer = Uint8List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image!.getPixel(j, i);
      buffer[pixelIndex++] = getRed(pixel);
      buffer[pixelIndex++] = getGreen(pixel);
      buffer[pixelIndex++] = getBlue(pixel);
    }
  }
  return convertedBytes.buffer.asUint8List();
}