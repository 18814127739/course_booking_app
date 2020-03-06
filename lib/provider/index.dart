import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'current_index_provider.dart';
import 'large_image_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
  ChangeNotifierProvider(create: (_) => LargeImageProvider()),
];