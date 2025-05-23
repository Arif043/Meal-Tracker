String prepareValue(String rawValue) => rawValue.isEmpty ? 'Keine Daten 😢' :
'${rawValue}g';

String pretty(double val) => val.round() == val ? val.toInt().toString() : val.toString();