import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LivePriceController extends GetxController {
  // Observable prices
  var goldPriceUsd = 0.0.obs;
  var silverPriceUsd = 0.0.obs;
  var goldPriceNpr = 0.0.obs;
  var silverPriceNpr = 0.0.obs;

  // Change and percentage
  var goldChange = 0.0.obs;
  var silverChange = 0.0.obs;
  var goldPercent = 0.0.obs;
  var silverPercent = 0.0.obs;

  // Last updated time
  var lastUpdated = ''.obs;

  // Exchange rate USD → NPR
  var usdToNpr = 133.0.obs;

  Timer? _timer;

  /// Fetch latest USD → NPR exchange rate
  Future<void> fetchExchangeRate() async {
    try {
      final url = Uri.parse("https://open.er-api.com/v6/latest/USD");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rate = (data["rates"]["NPR"] as num).toDouble();
        usdToNpr.value = rate;
      }
    } catch (e) {
      print("Error fetching exchange rate: $e");
    }
  }

  /// Fetch gold & silver prices
  Future<void> fetchPrices() async {
    try {
      final url = Uri.parse("https://data-asg.goldprice.org/dbXRates/USD");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final item = data["items"][0];

        // USD per troy ounce
        final goldPerOz = (item["xauPrice"] as num).toDouble();
        final silverPerOz = (item["xagPrice"] as num).toDouble();

        // Accurate conversion: troy ounce → tola
        const gramPerOunce = 31.1035;
        const gramPerTola = 11.6638;
        const conversionFactor = gramPerTola / gramPerOunce;

        // USD per tola
        goldPriceUsd.value = goldPerOz * conversionFactor;
        silverPriceUsd.value = silverPerOz * conversionFactor;

        // Convert to NPR
        goldPriceNpr.value = goldPriceUsd.value * usdToNpr.value;
        silverPriceNpr.value = silverPriceUsd.value * usdToNpr.value;

        // Change in USD per tola
        final goldChangeUsd =
            (item["chgXau"] as num).toDouble() * conversionFactor;
        final silverChangeUsd =
            (item["chgXag"] as num).toDouble() * conversionFactor;

        // Change in NPR per tola
        goldChange.value = goldChangeUsd * usdToNpr.value;
        silverChange.value = silverChangeUsd * usdToNpr.value;

        // Percent change
        goldPercent.value = (item["pcXau"] as num).toDouble();
        silverPercent.value = (item["pcXag"] as num).toDouble();

        lastUpdated.value = data["date"];
      }
    } catch (e) {
      print("Error fetching prices: $e");
    }
  }

  /// Refresh both exchange rate & prices
  Future<void> refreshData() async {
    await fetchExchangeRate();
    await fetchPrices();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData();
    // Auto-refresh every 5 minutes
    _timer = Timer.periodic(const Duration(minutes: 5), (_) => refreshData());
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
