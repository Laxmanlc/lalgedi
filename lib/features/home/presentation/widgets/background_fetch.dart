import 'package:lalgedi/features/home/presentation/bloc/nepali_price_controller.dart';
import 'package:workmanager/workmanager.dart';

const fetchPricesTask = "fetchGoldSilverPriceTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchPricesTask) {
      final controller = GoldPriceController();
      await controller.fetchPrices();
    }
    return Future.value(true);
  });
}
