import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/app/styles/app_styles.dart';
import '../bloc/species_bloc.dart';
import '../bloc/events/species_event.dart';
import '../bloc/states/species_state.dart';

class SpeciesView extends StatelessWidget {
  const SpeciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Species')),
      body: BlocBuilder<SpeciesBloc, SpeciesState>(
        builder: (context, state) {
          if (state.isLoading && state.species.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null && state.species.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: AppStyles.headline1.bold(),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent * 0.8) {
                context.read<SpeciesBloc>().add(LoadNextPageIfNeeded());
              }
              return false;
            },
            child: ListView.builder(
              itemCount: state.species.length + 1,
              itemBuilder: (_, i) {
                if (i < state.species.length) {
                  final species = state.species[i];
                  return ListTile(
                    title: Text(species.name),
                    subtitle: Text(species.classification),
                  );
                }

                return state.isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
