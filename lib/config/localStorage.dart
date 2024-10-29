import 'dart:convert';
import 'package:hive/hive.dart';

class LocalStorage {
  static final _localStorage = Hive.box('localStorage');
  static addNotification(notification){
    var rawData=_localStorage.get("notifications");
    if(rawData!=null){
      List previousNotifications= jsonDecode(rawData);
      previousNotifications.add(notification);
      _localStorage.put("notifications",jsonEncode(previousNotifications));
    }
    else{
      List emptyNotifications=[];
      emptyNotifications.add(notification);
      _localStorage.put("notifications",jsonEncode(emptyNotifications));
    }
  }

  static getNotifications(){
    var rawData=_localStorage.get("notifications");
    if(rawData!=null){
      return jsonDecode(rawData);
    }
    else{
      return [];
    }
  }

}