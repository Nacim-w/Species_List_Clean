import 'package:equatable/equatable.dart';

abstract class SpeciesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSpeciesEvent extends SpeciesEvent {}

class LoadNextPageIfNeeded extends SpeciesEvent {}
