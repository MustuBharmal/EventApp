class UsersModel {
  String? uid;
  String? img;
  String? name;
  String? usertype;
  String? emailId;
  String? dept;
  String? branch;
  String? phoneNo;

  UsersModel(
      {this.uid,
      this.img,
      this.name,
      this.usertype,
      this.emailId,
      this.dept,
      this.branch,
      this.phoneNo});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    String? uid = json['uid'];
    String? img = json['img'];
    String? name = json['name'];
    String? usertype = json['usertype'];
    String? emailId = json['emailId'];
    String? dept = json['dept'];
    String? branch = json['branch'];
    String? phoneNo = json['phoneNo'];
    return UsersModel(
      uid: uid,
      img: img,
      name: name,
      usertype: usertype,
      emailId: emailId,
      dept: dept,
      branch: branch,
      phoneNo: phoneNo,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['img'] = img;
    data['name'] = name;
    data['usertype'] = usertype;
    data['emailId'] = emailId;
    data['dept'] = dept;
    data['branch'] = branch;
    data['phoneNo'] = phoneNo;
    return data;
  }
}
