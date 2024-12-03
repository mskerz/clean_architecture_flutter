// To parse this JSON data, do
//
//     final tags = tagsFromJson(jsonString);

import 'dart:convert';

List<Tags> tagsFromJson(String str) => List<Tags>.from(json.decode(str).map((x) => Tags.fromJson(x)));

String tagsToJson(List<Tags> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tags {
    String slug;
    String name;
    String url;

    Tags({
        required this.slug,
        required this.name,
        required this.url,
    });

    factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
    };
}
