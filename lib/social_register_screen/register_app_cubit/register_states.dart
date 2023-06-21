abstract class socialRegisterStates{}

class socialRegisterInitialStates extends socialRegisterStates{}
class socialRegisterLoadongStates extends socialRegisterStates{}
class socialRegisterSuccessStates extends socialRegisterStates{}
class socialRegisterErrorStates extends socialRegisterStates{


  final String Error;

  socialRegisterErrorStates(this.Error);
}
class socialRegisterChangePassworsdVisibilityState extends socialRegisterStates{}
class socialCreateUserSuccessStates extends socialRegisterStates{}
class socialCreateUserErrorStates extends socialRegisterStates{


  final String Error;

  socialCreateUserErrorStates(this.Error);
}



