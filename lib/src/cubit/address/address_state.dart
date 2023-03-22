part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoadingProvince extends AddressState {}

class AddressLoadingDistrict extends AddressState {}

class AddressLoadingWard extends AddressState {}

class AddressLoadFailed extends AddressState {
  final String msg;
  const AddressLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class AddressLoaded extends AddressState {
  final List<Province> provinces;
  final Province province;
  final List<District>? districts;
  final District? district;
  final List<Ward>? wards;
  final Ward? ward;
  const AddressLoaded(
      {required this.provinces,
      required this.province,
      this.districts,
      this.district,
      this.wards,
      this.ward});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [provinces, province, districts, district, wards, ward];
}
