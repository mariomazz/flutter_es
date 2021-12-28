import 'package:deo_demo/core/api_service/api_service.dart';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/core/providers/connectivity/connectivity_status.dart';
import 'package:deo_demo/core/providers/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProviders {
  static List<SingleChildWidget> getProviders() {
    return [
      ListenableProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        dispose: (context, provider) => provider.dispose(),
      ),
      ListenableProvider<NavigatorProvider>(
        create: (context) => NavigatorProvider(),
        dispose: (context, provider) => provider.dispose(),
      ),
      ListenableProvider<ConnectivityService>(
        create: (context) => ConnectivityService(),
        dispose: (context, provider) => provider.dispose(),
      ),
      Provider<ApiService>(
        create: (context) => ApiService(context),
        dispose: (context, apiService) {},
      ),
    ];
  }
}
