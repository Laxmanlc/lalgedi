import 'package:get/get.dart';

class AccountController extends GetxController {
  // Reactive user data
  var userName = "Ashish BK".obs;
  var profileImage = "assets/image/profilepic.jpg".obs;

  // Example: Notification toggle
  var notificationsEnabled = true.obs;

  // Methods to update
  void updateUserName(String newName) => userName.value = newName;
  void updateProfileImage(String newImage) => profileImage.value = newImage;
  void toggleNotifications() =>
      notificationsEnabled.value = !notificationsEnabled.value;
}
