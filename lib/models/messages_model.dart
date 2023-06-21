class MessageModel{
    String? reciverID;
    String? senderID;
    String? dateTime;
    String? text;
  MessageModel({required this.reciverID,required this.senderID,required this.dateTime,required this.text});
  MessageModel.fromJson(Map<String,dynamic> json){
    reciverID=json['reciverID'];
    senderID=json['senderID'];
    dateTime=json['dateTime'];
    text=json['text'];

  }

  Map<String, dynamic> toMap() {
    return {
      'reciverID': reciverID,
      'senderID': senderID,
      'dateTime': dateTime,
      'text': text,
    };
  }
}