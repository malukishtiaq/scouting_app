import '../../../../../core/params/base_params.dart';

class MemberGetParam extends BaseParams {
  final int id;
  final String email;

  MemberGetParam({this.id = 0, this.email = ""});

  @override
  Map<String, dynamic> toMap() => {
        if (id > 0) "Id": id,
        if (email.isNotEmpty) "Email": email,
      };
}
