import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/core/res/styles/colours.dart';
import 'package:list_test/features/Home/presentation/bloc/events/species_event.dart';
import 'core/di.dart';
import 'features/Home/presentation/views/species_view.dart';
import 'features/Home/presentation/bloc/species_bloc.dart';

void main() {
  init(); // DI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Species List',
      theme: ThemeData(primaryColor: Colours.lightThemeOrange1),
      home: BlocProvider(
        create: (_) => sl<SpeciesBloc>()..add(FetchSpeciesEvent()),
        child: const SpeciesView(),
      ),
    );
  }
}
