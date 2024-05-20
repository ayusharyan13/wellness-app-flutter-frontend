import 'package:get/get.dart';

class SuggestionController extends GetxController {
  var suggestionValue = ''.obs;

  void setString(String value) {
    suggestionValue.value = value;
  }
}
