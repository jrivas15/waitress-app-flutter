import 'package:intl/intl.dart';

String formatNumber(double numero) =>
    NumberFormat('#,##0.0', 'es_ES').format(numero);
