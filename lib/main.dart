import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/group_repository.dart';

import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/blocs/auth/auth_event.dart';
import 'logic/blocs/auth/auth_state.dart';

import 'logic/blocs/group/group_bloc.dart';
import 'logic/blocs/group/group_event.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/group_list_screen.dart';
import 'presentation/screens/home/create_group_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Optional for development
  await FirebaseAuth.instance.signOut();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create:
            (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())
                  ..add(CheckAuthStatus()),
        child: const MaterialAppWithAuth(),
      ),
    );
  }
}

class MaterialAppWithAuth extends StatelessWidget {
  const MaterialAppWithAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Study Group App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: _buildHome(state),
          routes: {
            '/login': (context) => const LoginScreen(),

            // ✅ Provide GroupBloc for group-related screens
            '/group-list':
                (context) => BlocProvider(
                  create:
                      (_) =>
                          GroupBloc(groupRepository: GroupRepository())
                            ..add(LoadGroups()),
                  child: const GroupListScreen(),
                ),

            '/create-group':
                (context) => BlocProvider(
                  create: (_) => GroupBloc(groupRepository: GroupRepository()),
                  child: const CreateGroupScreen(),
                ),
          },
        );
      },
    );
  }

  Widget _buildHome(AuthState state) {
    if (state is Authenticated) {
      return BlocProvider(
        create:
            (_) =>
                GroupBloc(groupRepository: GroupRepository())
                  ..add(LoadGroups()),
        child: const GroupListScreen(),
      );
    } else if (state is Unauthenticated || state is AuthFailure) {
      return const LoginScreen();
    } else {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
