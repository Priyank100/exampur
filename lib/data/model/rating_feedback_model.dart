class RatingFeedbackModel {
  String? name;
  String? rating;
  String? date;

  RatingFeedbackModel(this.name, this.rating, this.date);

  // factory RatingFeedbackModel.fromJson(Map<String, dynamic> parsedJson) {
  //   return new RatingFeedbackModel(
  //       name: parsedJson['name'] ?? "",
  //       rating: parsedJson['rating'] ?? "",
  //       date: parsedJson['date'] ?? "");
  // }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "rating": this.rating,
      "date": this.date
    };
  }
}