import 'package:get/get.dart';

class LivePriceController extends GetxController {
  var goldPrice = "0".obs;
  var silverPrice = "0".obs;
  var goldChange = "0".obs;
  var silverChange = "0".obs;

  void updatePrices(
      String gold, String silver, String gChange, String sChange) {
    goldPrice.value = gold;
    silverPrice.value = silver;
    goldChange.value = gChange;
    silverChange.value = sChange;
  }
}
