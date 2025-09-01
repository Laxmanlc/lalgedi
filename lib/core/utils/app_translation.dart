import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // ---------------- Home ----------------
          "home.live_price": "Live Price",
          "home.gold": "Gold",
          "home.silver": "Silver",
          "home.gold_rate": "Gold Rate",
          "home.silver_rate": "Silver Rate",
          "home.international_gold_news": "International Gold News",
          "home.calculate": "Calculate",
          "home.summary": "Summary",
          "home.simple_jewelry_calculator": "Simple Jewelry Calculator",

          // ---------------- Account ----------------
          "account.account": "Account",
          "account.language": "Language",
          "account.appearance": "Appearance",
          "account.dark_mode": "Dark Mode",
          "account.light_mode": "Light Mode",
          "account.change_theme": "Change app theme",
          "account.change_language": "Change language in app",
          "account.notification": "Notification",
          "account.help_support": "Help and Support",
          "account.report_bugs": "Report Bugs",
          "account.privacy_policy": "Privacy Policy",
          "account.terms_condition": "Terms & Condition",
          "account.about_us": "About Us",
          "account.facebook_page": "Facebook Page",
          "account.connect_whatsapp": "Connect To WhatsApp",
          "account.logout": "Logout",

          // ---------------- General ----------------
          "general.ok": "OK",
          "general.close": "Close",
          "general.next": "Next",
          "general.done": "Done",
          "general.today": "Today",
          "general.today_rate": "Today's Rate",
          "general.per_tola": "Per tola",
          "general.gold_qty": "Gold Quantity",
          "general.wastage": "Wastage",
          "general.making_fee": "Making Fee",
          "general.gold_value": "Gold Value: @quantity tola",
          "general.wastage_value": "Wastage : @quantity%",
          "general.estimated_cost": "Estimated Cost : ",
          "general.chose_loan_date": "Please Pick Loan date",
          "general.loan_date_cant_be_future":
              "Loan date cannot be in the future.",
          "general.loan_calculator": "LOAN CALCULATOR",
          "general.loan_amount": "Loan Amount",
          "general.enter_loan_amount": "Enter a Loan Amount",
          "general.invalid_amount": "Invalid Amount",
          "general.loan_date": "Loan Date",
          "general.pick_date": "Pick a Date",
          "general.interest_rate": "Interest rate",
          "general.enter_annual_rate": "Enter Annual Rate",
          "general.invalid_rate": "Invalid rate",
          "general.rate_must_be": "Rate must be 0–100",
          "general.loan_summary": "Loan Summary",
          "general.total_payable": "Total Payable",
          "general.interest": "Interest",

          // ---------------- Settings ----------------
          "setting.title": "Settings",
          "setting.appearance.title": "Appearance",
          "setting.appearance.description": "Change app theme",
          "setting.language.title": "Language",
          "setting.language.description": "Change language in app",
          "setting.unit_system.title": "Unit system",
          "setting.unit_system.description":
              "Change Unit system for gold and silver",
          "setting.calendar.title": "Calendar",
          "setting.calendar.description": "Change calendar system",
          "setting.notification.title": "Notification",
          "setting.notification.enabled": "Enabled",
          "setting.notification.disabled": "Disabled",

          // ---------------- Help & Support ----------------
          "help_support.title": "Help and Support",
          "help_support.whatsapp.title": "Connect To WhatsApp",
          "help_support.whatsapp.description": "Connect with us in whatsapp",
          "help_support.facebook.title": "Facebook Page",
          "help_support.facebook.description": "LalGedi facebook page",
          "help_support.email.title": "Email Support",
          "help_support.email.description": "Email us for any support",
          "help_support.in_app.title": "In-App Support",
          "help_support.in_app.description": "Chat ai assistant of app",
          "help_support.report_bugs.title": "Report Bugs",
          "help_support.report_bugs.description": "Report Bugs of app",

          // ---------------- Legal ----------------
          "legal.title": "Legal",
          "legal.terms.title": "Terms and Condition",
          "legal.terms.description": "Terms and Condition of app",
          "legal.privacy.title": "Privacy Policy",
          "legal.privacy.description": "Our privacy policy",
          "legal.about.title": "About Us",
          "legal.about.description": "About lalgedi App",

          // ---------------- Profile ----------------
          "profile.title": "Profile Setting",
          "profile.setting.title": "Profile Setting",
          "profile.setting.description": "Logout, change and forgot password",
        },
        'ne_NP': {
          // ---------------- Home ----------------
          "home.live_price": "प्रत्यक्ष मूल्य",
          "home.gold": "सुन",
          "home.silver": "चाँदी",
          "home.gold_rate": "सुन दर",
          "home.silver_rate": "चाँदी दर",
          "home.international_gold_news": "अन्तर्राष्ट्रिय सुन समाचार",
          "home.calculate": "गणना गर्नुहोस्",
          "home.summary": "सारांश",
          "home.simple_jewelry_calculator": "सरल गहना क्याल्कुलेटर",

          // ---------------- Account ----------------
          "account.account": "खाता",
          "account.language": "भाषा",
          "account.appearance": "देखावट",
          "account.dark_mode": "अँध्यारो मोड",
          "account.light_mode": "उज्यालो मोड",
          "account.change_theme": "एपको थिम परिवर्तन गर्नुहोस्",
          "account.change_language": "एपमा भाषा परिवर्तन गर्नुहोस्",
          "account.notification": "सूचना",
          "account.help_support": "सहायता र समर्थन",
          "account.report_bugs": "त्रुटिहरू रिपोर्ट गर्नुहोस्",
          "account.privacy_policy": "गोपनीयता नीति",
          "account.terms_condition": "सर्त र सर्तहरू",
          "account.about_us": "हाम्रोबारे",
          "account.facebook_page": "फेसबुक पेज",
          "account.connect_whatsapp": "ह्वाट्सएपमा जडान गर्नुहोस्",
          "account.logout": "लगआउट",

          // ---------------- General ----------------
          "general.ok": "ठिक छ",
          "general.close": "बन्द गर्नुहोस्",
          "general.next": "अर्को",
          "general.done": "पूरा भयो",
          "general.today": "आज",
          "general.today_rate": "आजको दर",
          "general.per_tola": "प्रति तोला",
          "general.gold_qty": "सुनको मात्रा",
          "general.wastage": "बर्बादी",
          "general.making_fee": "बनाउने शुल्क ",
          "general.gold_value": "सुनको मूल्य : @quantity तोला",
          "general.wastage_value": "बर्बाद मूल्य : @quantity%",
          "general.estimated_cost": "अनुमानित लागत :",
          "general.chose_loan_date": "कृपया ऋण मिति छान्नुहोस्",
          "general.loan_date_cant_be_future": "ऋण मिति भविष्यमा हुन सक्दैन",
          "general.loan_calculator": "ऋण क्याल्कुलेटर",
          "general.loan_amount": "ऋण रकम",
          "general.enter_loan_amount": "ऋण रकम प्रविष्ट गर्नुहोस्",
          "general.invalid_amount": "अवैध रकम",
          "general.loan_date": "ऋण मिति",
          "general.pick_date": "मिति छान्नुहोस्",
          "general.interest_rate": "ब्याज दर",
          "general.enter_annual_rate": "वार्षिक दर प्रविष्ट गर्नुहोस्",
          "general.invalid_rate": "अवैध दर",
          "general.rate_must_be": "दर 0-100 हुनुपर्छ",
          "general.loan_summary": "ऋण सारांश",
          "general.total_payable": "कुल भुक्तान योग्य :",
          "general.interest": "ब्याज :(@quantity) दिन",

          // ---------------- Settings ----------------
          "setting.title": "सेटिङहरू",
          "setting.appearance.title": "देखावट",
          "setting.appearance.description": "एपको थिम परिवर्तन गर्नुहोस्",
          "setting.language.title": "भाषा",
          "setting.language.description": "एपमा भाषा परिवर्तन गर्नुहोस्",
          "setting.unit_system.title": "एकाइ प्रणाली",
          "setting.unit_system.description":
              "सुन र चाँदीको एकाइ प्रणाली परिवर्तन गर्नुहोस्",
          "setting.calendar.title": "क्यालेन्डर",
          "setting.calendar.description":
              "क्यालेन्डर प्रणाली परिवर्तन गर्नुहोस्",
          "setting.notification.title": "सूचना",
          "setting.notification.enabled": "सक्रिय",
          "setting.notification.disabled": "असक्रिय",

          // ---------------- Help & Support ----------------
          "help_support.title": "सहायता र समर्थन",
          "help_support.whatsapp.title": "व्हाट्सएपमा जडान गर्नुहोस्",
          "help_support.whatsapp.description":
              "हामीसँग WhatsApp मा जडान गर्नुहोस्",
          "help_support.facebook.title": "फेसबुक पेज",
          "help_support.facebook.description": "LalGedi फेसबुक पेज",
          "help_support.email.title": "ईमेल समर्थन",
          "help_support.email.description":
              "कुनै पनि समर्थनका लागि हामीलाई ईमेल गर्नुहोस्",
          "help_support.in_app.title": "इन-एप समर्थन",
          "help_support.in_app.description":
              "एपको AI सहायकसँग कुराकानी गर्नुहोस्",
          "help_support.report_bugs.title": "बग रिपोर्ट गर्नुहोस्",
          "help_support.report_bugs.description": "एपको बग रिपोर्ट गर्नुहोस्",

          // ---------------- Legal ----------------
          "legal.title": "कानुनी",
          "legal.terms.title": "सर्त र शर्तहरू",
          "legal.terms.description": "एपको सर्त र शर्तहरू",
          "legal.privacy.title": "गोपनीयता नीति",
          "legal.privacy.description": "हाम्रो गोपनीयता नीति",
          "legal.about.title": "हाम्रोबारे",
          "legal.about.description": "LalGedi एपको बारेमा",

          // ---------------- Profile ----------------
          "profile.title": "प्रोफाइल सेटिङ",
          "profile.setting.title": "प्रोफाइल सेटिङ",
          "profile.setting.description": "लगआउट, परिवर्तन र पासवर्ड भुल्नु भयो",
        }
      };
}
