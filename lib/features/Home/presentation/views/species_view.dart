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
          // Show full-screen loading if first page is loading
          if (state.isLoading && state.species.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          // Show error if there is one and no data
          if (state.errorMessage != null && state.species.isEmpty) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: AppStyles.headline1.bold(),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.species.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(state.species[i].name),
                    subtitle: Text(state.species[i].classification),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (!state.isLoading && state.currentPage > 1)
                        ? () => context.read<SpeciesBloc>().add(
                            PreviousPageEvent(),
                          )
                        : null,
                    child: (state.isLoading && state.loadingButton == "prev")
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Prev',
                            style: AppStyles.caption.bold().accent(),
                          ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: (!state.isLoading && state.hasNextPage)
                        ? () => context.read<SpeciesBloc>().add(NextPageEvent())
                        : null,
                    child: (state.isLoading && state.loadingButton == "next")
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Next',
                            style: AppStyles.caption.bold().accent(),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
