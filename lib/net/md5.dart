import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

String md5(String data) {
  var content = utf8.encode(data);
  var digest = sha1.convert(content);
  return hex.encode(digest.bytes);
}
