/// Small, defensive helpers used by every `fromJson` factory so that a
/// missing or wrongly typed field never crashes the app.
typedef Json = Map<String, dynamic>;

Json jsonMap(dynamic value) => value is Map<String, dynamic> ? value : const {};

List<Json> jsonList(dynamic value) =>
    value is List ? value.whereType<Map<String, dynamic>>().toList() : const [];

String jsonString(dynamic value, [String fallback = '']) =>
    value is String ? value : fallback;

int jsonInt(dynamic value, [int fallback = 0]) =>
    value is num ? value.toInt() : fallback;

double jsonDouble(dynamic value, [double fallback = 0]) =>
    value is num ? value.toDouble() : fallback;

bool jsonBool(dynamic value, [bool fallback = false]) =>
    value is bool ? value : fallback;
