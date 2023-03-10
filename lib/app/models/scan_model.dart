import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) =>
    ScanModel.fromJson(json.decode(str) as Map<String, dynamic>);
// Required to cast by https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=argument_type_not_assignable#argument_type_not_assignable

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({ required this.value, this.id = 0, this.type = '' }) {
    if (value.contains('http')) {
      type = 'http';
    } else {
      type = 'geo';
    }
  }

  int id;
  String type;
  String value;

  LatLng getLatLng() {
    final latLng = value.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json['id'] as int,
        type: json['type'].toString(),
        value: json['value'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'value': value,
      };
}
