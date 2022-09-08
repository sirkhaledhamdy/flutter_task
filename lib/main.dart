import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/view/user_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc_observer.dart';
import 'control/cubit/appCubit.dart';
import 'control/cubit/appStates.dart';
import 'control/remote/dio_helper.dart';
import 'model/hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserAdapter());
  await Hive.openBox('users');


  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DioHelper.init();

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((_) {
        runApp(const MyApp(
        ));
      });
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..getUsersData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'task',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const UserScreen(),
          );
        },
      ),
    );
  }
}

