import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/app/colors/app_colors.dart';
import 'package:list_test/features/Home/presentation/bloc/events/species_event.dart';
import 'package:list_test/features/Home/presentation/bloc/species_bloc.dart';
import 'package:list_test/features/Home/presentation/views/species_view.dart';
import '../core/di.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Species List',
      theme: ThemeData(primaryColor: AppColors.primary),
      home: BlocProvider(
        create: (_) => sl<SpeciesBloc>()..add(FetchSpeciesEvent()),
        child: const SpeciesView(),
      ),
    );
  }
}
