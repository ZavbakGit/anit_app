import 'package:anit_app/common/bloc/base_event.dart';

class ChangedTextEvent extends BaseEvent {
  final String text;

  ChangedTextEvent({this.text});

  @override
  List<Object> get props => [text];
}

