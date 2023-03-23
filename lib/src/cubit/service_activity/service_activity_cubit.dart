import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'service_activity_state.dart';

class ServiceActivityCubit extends Cubit<ServiceActivityState> {
  ServiceActivityCubit() : super(ServiceActivityInitial());
}
