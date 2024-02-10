part of 'generate_text_bloc.dart';

sealed class GenerateTextEvent extends Equatable {
  const GenerateTextEvent();

  @override
  List<Object> get props => [];
}

final class GenerateText extends GenerateTextEvent {
  final String prompt;
  const GenerateText({required this.prompt});
}

final class StopGeneratingText extends GenerateTextEvent {}
