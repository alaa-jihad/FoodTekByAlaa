import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodtek_app/feature/splash_screen/presentaion/view/splash_screen.dart';
import 'package:foodtek_app/core/validation/presentation/cubit/validation_cubit.dart';
import 'package:foodtek_app/core/validation/domain/repositories/validation_repository.dart';
import 'package:foodtek_app/feature/sign_in/presentation/cubit/signin_cubit.dart';
import 'package:foodtek_app/core/validation/data/repositories/validation_repository_imp.dart';
import 'package:foodtek_app/feature/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:foodtek_app/feature/sign_up/presentation/cubit/signup_cubit.dart';
import 'package:foodtek_app/feature/verification/presentation/cubit/verification_cubit.dart';

import 'feature/cart/presentation/cubit/cart_cubit.dart';
import 'feature/favorites/presentation/cubit/fav_cubit.dart';
import 'feature/favorites/presentation/state/fav_event.dart';
import 'feature/forget_password/presentation/cubit/forget_password-cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ValidationRepository>(
          create: (context) => ValidationRepositoryImpl(),
        ),
        BlocProvider<ValidationCubit>(
          create: (context) => ValidationCubit(
            validationRepository: context.read<ValidationRepository>(),
          ),
        ),
        BlocProvider<SignInCubit>(
          create: (context) => SignInCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(
            validationRepository: context.read<ValidationRepository>(),
          ),
        ),
        BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(
            validationRepository: context.read<ValidationRepository>(),
          ),
        ),
        BlocProvider<VerificationCubit>(
          create: (context) => VerificationCubit(
            validationRepository: context.read<ValidationRepository>(),
          ),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => ResetPasswordCubit(
            validationRepository: context.read<ValidationRepository>(),
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc()..add(LoadFavorites()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}