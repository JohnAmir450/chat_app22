abstract class socialLoginStates{}

class socialLoginInitialStates extends socialLoginStates{}
class socialLoginLoadongStates extends socialLoginStates{}
class socialLoginSuccessStates extends socialLoginStates{
final String uId;

  socialLoginSuccessStates(this.uId);
}
class socialLoginErrorStates extends socialLoginStates{


  final String Error;

  socialLoginErrorStates(this.Error);
}
class socialChangePassworsdVisibilityState extends socialLoginStates{}