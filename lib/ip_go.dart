import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class IpGo {
  static Future<String?> get privateIp async {
    try {
      final List<NetworkInterface> interfaces = await NetworkInterface.list(
          type: InternetAddressType.any, includeLinkLocal: true);
      for (final interface in interfaces) {
        for (final value in interface.addresses) {
          if (value.type == InternetAddressType.IPv4 &&
              !value.isLoopback &&
              !value.address.startsWith("169.254")) {
            return value.address;
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> get publicIp async {
    try {
      final response =
          await http.get(Uri.parse("https://api.ipify.org?format=json"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["ip"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
