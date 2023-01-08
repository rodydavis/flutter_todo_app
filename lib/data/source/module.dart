import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'files.dart';
import 'files_memory_impl.dart';

final filesProvider = Provider<Files>((ref) {
  return FilesMemoryImpl();
});
