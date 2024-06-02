import 'package:admin/admin.dart';
import 'package:birthday_app/feature/app/presentation/app_page.dart';
import 'package:birthday_app/feature/auth/domain/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AuthCubit>()..checkAuthentication(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppPage(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final FirebaseApp app = Firebase.app();
//   late final FirebaseDatabase _database =
//       FirebaseDatabase.instanceFor(app: app);
//
//   DatabaseReference ref = FirebaseDatabase.instance.ref("users");
//
//   bool _showFunctionality = false;
//
//   bool get showFunctionality => _showFunctionality;
//
//   @override
//   void initState() {
//     // _database.ref("users").remove();
//
//     if ((ref.key?.length ?? 0) == 0) {
//       _showFunctionality = true;
//     }
//
//     ref.onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         _showFunctionality = true;
//       } else {
//         _showFunctionality = false;
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child:
//               showFunctionality ? const AdminMainPage() : const UserMainPage()),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
