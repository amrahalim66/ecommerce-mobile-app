import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/screens/splash_screen.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/product_cubit.dart';
import 'cubits/cart_cubit.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/product_screen.dart';
import 'screens/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => ProductCubit()..fetchProductsFromJson()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(fontFamily: 'Cairo'),
        home: const SplashScreen(),
        routes: {'/cart': (context) => const CartScreen()},
      ),
    );
  }
}
