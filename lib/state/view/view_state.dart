import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

@freezed
class ViewState with _$ViewState {
  const factory ViewState.initial() = ViewStateInitial;
  const factory ViewState.success() = ViewStateSuccess;
  const factory ViewState.loading() = ViewStateLoading;
  const factory ViewState.failed() = ViewStateFailed;
}
