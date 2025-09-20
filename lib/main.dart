import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_system/data/datasource/auth_local_datasource.dart';
import 'package:pos_system/data/datasource/item_remote_datasource.dart';
import 'package:pos_system/ui/bloc/item/item_bloc.dart';
import 'package:pos_system/ui/bloc/login/login_bloc.dart';
import 'package:pos_system/ui/bloc/logout/logout_bloc.dart';
import 'package:pos_system/ui/page/home_page.dart';
import 'package:pos_system/ui/page/login_page.dart';

// import bloc login
import 'package:pos_system/data/datasource/auth_remote_datasource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(AuthRemoteDataSource())),
        BlocProvider(
          create: (context) =>
              LogoutBloc(authRemoteDatasource: AuthRemoteDataSource()),
        ),
        BlocProvider(create: (_) => ItemBloc(ItemRemoteDatasource ())..add(ItemFetched())),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter POS',
        // tambahin routes disini 👇
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        },
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isAuthData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasData && snapshot.data == true) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
