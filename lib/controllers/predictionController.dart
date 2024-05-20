import 'package:get/get.dart';

class PredictionController extends GetxController {
  var predictionValue = ''.obs;

  void setString(String value) {
    predictionValue.value = value;
  }
}
