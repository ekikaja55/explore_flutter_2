import 'package:logger/logger.dart';

class MyLogger {
  static final MyLogger _instance = MyLogger._internal();
  factory MyLogger() => _instance;
  MyLogger._internal();

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Berapa banyak baris stacktrace yang mau ditampilin
      errorMethodCount:
          8, // Kalau error, tampilin baris stacktrace lebih banyak
      lineLength: 80, // Lebar garis pembatas
      colors: true, // Aktifkan warna (bagus buat terminal Linux)
      printEmojis: true, // Biar ada icon lucu di log-nya
      dateTimeFormat:
          DateTimeFormat.onlyTimeAndSinceStart, // Nampilin waktu log dikirim
    ),
  );

  void t(dynamic message) => _logger.t(message);

  void d(dynamic message) => _logger.d(message);

  void i(dynamic message) => _logger.i(message);

  void w(dynamic message) => _logger.w(message);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  void f(dynamic message) => _logger.f(message);
}
