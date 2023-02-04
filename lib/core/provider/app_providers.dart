import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/auth_repository/auth_repository.dart';
import '../../repositories/auth_repository/auth_repository_impl.dart';
import '../rest_client/custom_dio.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CustomDio()),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(dio: context.read()),
        )
      ],
      child: child,
    );
  }
}
