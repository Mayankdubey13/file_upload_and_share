
abstract class LoginEvent{

}

class SucessLoginEvent extends LoginEvent{
  final email;
  final password;
  SucessLoginEvent({required this.email,required this.password});
}

class ShowPasswordEvent extends LoginEvent{

}
