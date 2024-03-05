abstract class SignUpEvent{

}

class SucessSignUpEvent extends SignUpEvent{
  final  email;
  final  password;
  final name;
     SucessSignUpEvent({required this.email , required this.password,required this.name});
}
class ShowPasswordEvent extends SignUpEvent{
  // final isObx;
  // ShowPasswordEvent({required this.isObx});
}
class ShowConformPasswordEvent extends SignUpEvent{

}