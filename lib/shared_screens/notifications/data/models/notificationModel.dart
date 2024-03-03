class NotificationModel {
  bool? success;
  int? code;
  String? message;
  NotificationModelData? data;

  NotificationModel({this.success, this.code, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new NotificationModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationModelData {
  List<Notifications>? notifications;
  Pagination? pagination;

  NotificationModelData({this.notifications, this.pagination});

  NotificationModelData.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? body;
  String? type;
  int? orderId;

  Notifications({this.id, this.title, this.body, this.type, this.orderId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['type'] = this.type;
    data['order_id'] = this.orderId;
    return data;
  }
}

class Pagination {
  int? total;
  dynamic perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  String? nextPageUrl;
  String? prevPageUrl;

  Pagination(
      {this.total,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.from,
        this.to,
        this.nextPageUrl,
        this.prevPageUrl});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}
