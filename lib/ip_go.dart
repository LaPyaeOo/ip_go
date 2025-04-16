import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io' as io show NetworkInterface, InternetAddressType;

/// Main class of IpGo package
class IpGo {

  /// To call privateIp() to get private IP address
  static Future<String?> get privateIp async {
    if (kIsWeb) {
      return null;
    } else {
      try {
        final List<io.NetworkInterface> interfaces =
            await io.NetworkInterface.list(
                type: io.InternetAddressType.any, includeLinkLocal: true);
        for (final interface in interfaces) {
          for (final value in interface.addresses) {
            if (value.type == io.InternetAddressType.IPv4 &&
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
  }

  /// To call publicIp() to get public IP address
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
