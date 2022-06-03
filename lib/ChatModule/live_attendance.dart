class LiveAttendance {
  String videoId;
  String date;
  String time;
  String name;
  String mobile;

  LiveAttendance(this.videoId, this.date, this.time, this.name, this.mobile);

  factory LiveAttendance.fromJson(dynamic json) {
    return LiveAttendance(
        "${json['videoId']}",
        "${json['date']}",
        "${json['time']}",
        "${json['name']}",
        "${json['mobile']}"
    );
  }

  Map toJson() => {
    'videoId': videoId,
    'date': date,
    'time': time,
    'name': name,
    'mobile': mobile,
  };
}