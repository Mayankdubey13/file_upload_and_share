abstract class LoginState{

}
class IntialState extends LoginState{
//final PasswordStatus passwordStatus;

  IntialState();
}
class SucessLoginState extends LoginState{

}
class ErrorLoginState extends LoginState{
  String error;
  ErrorLoginState({required this.error});
}
class ShowPasswordState extends LoginState{

}


// enum PasswordStatus {hidden, show}