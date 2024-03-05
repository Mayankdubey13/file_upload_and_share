class SignupState {

}

class IntialState extends SignupState{

}
class SucessSignUpState extends SignupState{

}
class ErrorSignUpState extends SignupState{
 final  error;
 ErrorSignUpState({required this.error});
}
class ShowPasswordState extends SignupState{
}

class ShowConFormPasswordState extends SignupState{

}