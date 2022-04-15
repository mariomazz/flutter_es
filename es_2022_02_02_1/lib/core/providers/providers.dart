import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../routing/my_router_delegate.dart';

class MyProviders {
  static final List<SingleChildWidget> providers = [
    ListenableProvider<MyRouterDelegate>(
      create: (context) => MyRouterDelegate.instance,
      dispose: (context, provider) => provider.dispose(),
    ),
  ];
}
