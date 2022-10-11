part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class GetLoginEvent extends LoginEvent {
  final String? email;
  final bool? remember;
  final String? password;
  final BuildContext? context;

  const GetLoginEvent({this.email, this.password, this.context, this.remember});

  @override
  List<Object?> get props => [];
}

class ForgotPassEvent extends LoginEvent {
  final String? email;
  final BuildContext? context;

  const ForgotPassEvent({this.email, this.context});

  @override
  List<Object?> get props => [];
}

class OtpVerifyEvent extends LoginEvent {
  final String? email;
  final String? otp;
  final BuildContext? context;

  const OtpVerifyEvent({this.email, this.context, this.otp});

  @override
  List<Object?> get props => [];
}

class ResetPasswordEvent extends LoginEvent {
  final String? email;
  final BuildContext? context;
  final String? password;
  final String? confirmPassword;

  const ResetPasswordEvent(
      {this.email, this.context, this.password, this.confirmPassword});

  @override
  List<Object?> get props => [];
}

class logoutEvent extends LoginEvent {
  final BuildContext? context;

  const logoutEvent({
    this.context,
  });

  @override
  List<Object?> get props => [];
}

class ChangePassEvent extends LoginEvent {
  final BuildContext? context;
  final String? oldPassword;
  final String? newPassword;

  const ChangePassEvent({this.context, this.oldPassword, this.newPassword});

  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends LoginEvent {
  final String? name;
  var image;
  final BuildContext? context;

  UpdateProfileEvent({this.name, this.image, this.context});

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends LoginEvent {
  final BuildContext ? context;
  GetProfileEvent({this.context});
  @override
  List<Object?> get props => [];
}

class ChangeInfoEvent extends LoginEvent {
  final String? name;

  ChangeInfoEvent({this.name, this.image});

  var image;

  @override
  List<Object?> get props => [];
}

class AddSiteSurveyFormEvent extends LoginEvent {
  final String? length;
  final String? width;
  final String? onloadingLocation;
  final String? offloadingLocation;
  final String? createdAt;
  final String? updatedAt;


  AddSiteSurveyFormEvent({
    this.length,
    this.width,
    this.onloadingLocation,
    this.offloadingLocation,
    this.createdAt,
    this.updatedAt
  });

  @override
  List<Object?> get props => [];
}
class UpdateLayoutPlanImageEvent extends LoginEvent {
  final String? image;
  final String? description;
  final String? createdAt;
  final String? updatedAt;


  UpdateLayoutPlanImageEvent({
    this.image,
    this.description,
    this.createdAt,
    this.updatedAt
  });

  @override
  List<Object?> get props => [];
}
class Upload360Image extends LoginEvent {
  final String? image360;
  final String? description;
  final String? createdAt;
  final String? updatedAt;


  Upload360Image({
    this.image360,
    this.description,
    this.createdAt,
    this.updatedAt
  });

  @override
  List<Object?> get props => [];
}
class ReportTypeEvent extends LoginEvent {
  final BuildContext? context;

  const ReportTypeEvent({required this.context});


  @override
  List<Object?> get props => [];
}
class GetReportTypeEvent extends LoginEvent {
  final BuildContext? context;


  GetReportTypeEvent({
    this.context,
  });

  @override
  List<Object?> get props => [];
}
class GetReportEvent extends LoginEvent {
  final BuildContext? context;

  const GetReportEvent({required this.context});

  @override
  List<Object?> get props => [];
}
class GetReportByIdEvent extends LoginEvent {
  final int? id;

  const GetReportByIdEvent({required this.id});

  @override
  List<Object?> get props => [];
}
class GetPunchListByIdEvent extends LoginEvent {
  final int? id;

  const GetPunchListByIdEvent({required this.id});

  @override
  List<Object?> get props => [];
}

class GetSiteSurveyDetailsEvent extends LoginEvent {
final BuildContext? context;
  const GetSiteSurveyDetailsEvent({required this.context});

  @override
  List<Object?> get props => [];
}
class AddReportEvent extends LoginEvent {
  final String? reportName;
  final String? createdAt;
  final String? updatedAt;

  const AddReportEvent({ this.reportName,this.updatedAt,this.createdAt});

  @override
  List<Object?> get props => [];
}
class InsertProjectDetails extends LoginEvent {

  final String? projectName;
  final String? address;
  final String? logo;
  final String? projectCategoryName;
  final String? projectCategoryColor;
  final String? createdAt;
  final String? updatedAt;
  final BuildContext? context;

    const InsertProjectDetails({ this.projectName,this.context,this.projectCategoryColor,this.projectCategoryName,this.address,this.logo,this.updatedAt,this.createdAt});

  @override
  List<Object?> get props => [];
}

class InsertPunchList extends LoginEvent {

  final String? referenceId;
  final String? beforeImage;
  final String? afterImage;
  final String? beforeDescription;
  final String? afterDescription;
  final String? expectedCompletionDate;
  final String? actualCompletionDate;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final BuildContext? context;

    const InsertPunchList({ this.referenceId,this.context,this.beforeImage,this.expectedCompletionDate,this.beforeDescription,this.afterImage,this.updatedAt,this.createdAt,this.afterDescription,this.actualCompletionDate,this.status});

  @override
  List<Object?> get props => [];
}
class UpdatePunchList extends LoginEvent {
  final int? id;
  final String? referenceId;
  final String? beforeImage;
  final String? afterImage;
  final String? beforeDescription;
  final String? afterDescription;
  final String? expectedCompletionDate;
  final String? actualCompletionDate;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final BuildContext? context;

    const UpdatePunchList({ this.id,this.referenceId,this.context,this.beforeImage,this.expectedCompletionDate,this.beforeDescription,this.afterImage,this.updatedAt,this.createdAt,this.afterDescription,this.actualCompletionDate,this.status});

  @override
  List<Object?> get props => [];
}

class GetPunchList extends LoginEvent {
  final BuildContext? context;

    const GetPunchList({ this.context});

  @override
  List<Object?> get props => [];
}
