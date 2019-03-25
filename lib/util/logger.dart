import 'package:simple_logger/simple_logger.dart';

// TODO: stacktraceEnabledはリリースビルドではfalseにする
final logger = SimpleLogger()
  ..mode = LoggerMode.print
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );
