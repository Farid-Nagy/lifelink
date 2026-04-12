import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class InternetService {
  /// يتحقق من وجود إنترنت فعلي
  /// يرجع true لو فيه، false لو مفيش
  static Future<bool> hasInternet() async {
    try {
      // التحقق من وجود شبكة (WiFi أو بيانات)
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false; // مفيش شبكة
      }

      // لو فيه شبكة، نجرب الوصول لموقع حقيقي
      try {
        final response = await http
            .get(Uri.parse('https://www.google.com'))
            .timeout(const Duration(seconds: 5));

        return response.statusCode == 200; // لو استجاب الموقع يبقى فيه إنترنت
      } catch (_) {
        return false; // الشبكة موجودة لكن مفيش إنترنت فعلي
      }
    } catch (_) {
      return false; // أي خطأ نعتبره مفيش نت
    }
  }
}