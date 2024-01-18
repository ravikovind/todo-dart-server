import 'dart:convert';
import 'package:flutter/foundation.dart';

/// [_parseAndDecode] is a function that takes a JSON [String] and parses the JSON string in background.
_parseAndDecode(String response) => jsonDecode(response);

/// [parseJSON] is a function that takes a JSON [String] and parses the JSON string in background.
/// compute is used to run the function in background. it opens a new isolate and runs the function in it.
parseJSON(String text) => compute(_parseAndDecode, text);
