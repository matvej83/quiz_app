import 'package:equatable/equatable.dart';
import 'package:quiz_app/features/profile/data/models/profile_model.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.firstName,
    required this.lastName,
    this.avatar,
  });

  final String firstName;
  final String lastName;
  final String? avatar;

  @override
  List<Object?> get props => [firstName, lastName, avatar];
}

extension ProfileEntityExt on ProfileEntity {
  ProfileModel toModel() =>
      ProfileModel(firstName: firstName, lastName: lastName, avatar: avatar);
}
