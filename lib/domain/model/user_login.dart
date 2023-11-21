
import 'package:hive/hive.dart';

class UserLogin {

  late bool success;

  late String? errorMsg;

  late String? jwtToken;

  late bool transVirtualLinkIsAuthorized;

  late String? currentClientName;

  late String? currentClientShortName;

  late String? transVirtualNumber;

  late String? currentUserFirstName;

  late String? currentUserLastName;

  late String? currentUserShortName;

  late String? warehouseTitle;

  late String? idWarehouse;

  late bool trackStockViaStockReceive;

  UserLogin({required this.success,
    required this.errorMsg,
    required this.jwtToken,
    required this.transVirtualLinkIsAuthorized,
    required this.currentClientName,
    required this.currentClientShortName,
    required this.transVirtualNumber,
    required this.currentUserFirstName,
    required this.currentUserLastName,
    required this.currentUserShortName,
    required this.warehouseTitle,
    required this.idWarehouse,
    required this.trackStockViaStockReceive});

  UserLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorMsg = json['errorMsg'];
    jwtToken = json['jwtToken'];
    transVirtualLinkIsAuthorized = json['transVirtualLinkIsAuthorized'];
    currentClientName = json['currentClientName'];
    currentClientShortName = json['currentClientShortName'];
    transVirtualNumber = json['transVirtualNumber'];
    currentUserFirstName = json['currentUserFirstName'];
    currentUserLastName = json['currentUserLastName'];
    currentUserShortName = json['currentUserShortName'];
    warehouseTitle = json['warehouseTitle'];
    idWarehouse = json['idWarehouse'];
    trackStockViaStockReceive = json['trackStockViaStockReceive'];
  }
}