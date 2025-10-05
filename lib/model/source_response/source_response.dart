class SourceResponse {
  String? status;
  String? message;
  String? code;
  List<Source>? sources;

  SourceResponse({this.status, this.sources, this.message, this.code});

  SourceResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    code = json["code"];
    sources = json["sources"] == null
        ? null
        : (json["sources"] as List).map((e) => Source.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    data["code"] = code;
    if (sources != null) {
      data["sources"] = sources?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Source {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  Source(
      {this.id,
      this.name,
      this.description,
      this.url,
      this.category,
      this.language,
      this.country});

  Source.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    url = json["url"];
    category = json["category"];
    language = json["language"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["url"] = url;
    data["category"] = category;
    data["language"] = language;
    data["country"] = country;
    return data;
  }
}
