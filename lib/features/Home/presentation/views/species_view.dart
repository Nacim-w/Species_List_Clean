import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_test/core/extensions/text_style_extension.dart';
import 'package:list_test/core/res/styles/text.dart';
import '../../../../core/di.dart';
import '../bloc/species_bloc.dart';
import '../bloc/events/species_event.dart';
import '../bloc/states/species_state.dart';

class SpeciesView extends StatelessWidget {
  const SpeciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SpeciesBloc>()..add(FetchSpeciesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Species')),
        body: Column(
          children: [
            Expanded(
              child: BlocSelector<SpeciesBloc, SpeciesState, List>(
                selector: (state) => state.species,
                builder: (_, species) => ListView.builder(
                  itemCount: species.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(species[i].name),
                    subtitle: Text(species[i].description),
                  ),
                ),
              ),
            ),

            BlocSelector<SpeciesBloc, SpeciesState, SpeciesState>(
              selector: (state) => state,
              builder: (context, s) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (!s.isLoading && s.currentPage > 1)
                        ? () => context.read<SpeciesBloc>().add(
                            PreviousPageEvent(),
                          )
                        : null,
                    child: (s.isLoading && s.loadingButton == "prev")
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Prev', style: TextStyles.textBoldSmall.orange1),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: (!s.isLoading && s.hasNextPage)
                        ? () => context.read<SpeciesBloc>().add(NextPageEvent())
                        : null,
                    child: (s.isLoading && s.loadingButton == "next")
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Next', style: TextStyles.textBoldSmall.orange1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
