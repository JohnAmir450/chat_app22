abstract class socialStates{}
class socialInitialstate extends socialStates{}
class socialGetUserScuccessstate extends socialStates{}
class socialGetUserErrorstate extends socialStates{
  final String error;

  socialGetUserErrorstate(this.error);
}
class socialGetUserLaoadingstate extends socialStates{}

class socialChangeBottomNavState extends socialStates{}
class socialNewPostState extends socialStates{}



class socialProfileImagePickedSuccessStates extends socialStates{}
class socialProfileImagePickedErrorStates extends socialStates{}


class socialCoverImagePickedSuccessStates extends socialStates{}
class socialCoverImagePickedErrorStates extends socialStates{}



class socialUploadProfileImageSuccessStates extends socialStates{}
class socialUploadProfileImageErrorStates extends socialStates{}


class socialUploadCoverImageSuccessStates extends socialStates{}
class socialUploadCoverImageErrorStates extends socialStates{}


class socialUserUpdateErrorStates extends socialStates{}
class socialUserUpdateLoadingStates extends socialStates{}

//new post states

class socialCreatePostErrorStates extends socialStates{}
class socialCreatePostLoadingStates extends socialStates{}
class socialCreatePostSuccessStates extends socialStates{}


class socialPostImagePickedSuccessStates extends socialStates{}
class socialPostImagePickedErrorStates extends socialStates{}

class socialRemovePostImagePickedStates extends socialStates{}


//get posts

class socialGetPostsScuccessstate extends socialStates{}
class socialGetPostsErrorstate extends socialStates{
  final String error;

  socialGetPostsErrorstate(this.error);
}
class socialGetPostsLaoadingstate extends socialStates{}

//like posts
class socialLikePostsScuccessstate extends socialStates{}
class socialLikePostsErrorstate extends socialStates{
  final String error;

  socialLikePostsErrorstate(this.error);
}
class socialLikePostsLaoadingstate extends socialStates{}

//get users in chats

class socialGetAllUsersScuccessstate extends socialStates{}
class socialGetAllUsersErrorstate extends socialStates{
  final String error;

  socialGetAllUsersErrorstate(this.error);
}
class socialGetAllUsersLaoadingstate extends socialStates{}

//chats

class socialSendMessageSuccessState extends socialStates{}
class socialSendMessageErrorState extends socialStates{}
class socialGetMessageSuccessState extends socialStates{}
class socialGetMessageErrorState extends socialStates{}



