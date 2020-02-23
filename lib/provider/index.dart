import 'package:provider/provider.dart';
import 'current_index_provider.dart';
import 'large_image_provider.dart';

List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider(builder: (_) => CurrentIndexProvider()),
  ChangeNotifierProvider(builder: (_) => LargeImageProvider()),
];