class EventModel {
  Request? request;
  num? count;
  List<Item>? item;

  EventModel({this.request, this.count, this.item});

  EventModel.fromJson(Map<String, dynamic> json) {
    request =
        json['request'] != null ? Request.fromJson(json['request']) : null;
    count = json['count'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
  }

  EventModel copyWith({
    Request? request,
    num? count,
    List<Item>? item,
  }) {
    return EventModel(
      request: request ?? this.request,
      count: count ?? this.count,
      item: item ?? this.item,
    );
  }
}

class Request {
  String? venue;
  String? ids;
  String? type;
  String? city;
  num? edate;
  num? page;
  String? keywords;
  num? sdate;
  String? category;
  String? cityDisplay;
  num? rows;

  Request(
      {this.venue,
      this.ids,
      this.type,
      this.city,
      this.edate,
      this.page,
      this.keywords,
      this.sdate,
      this.category,
      this.cityDisplay,
      this.rows});

  Request.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    ids = json['ids'];
    type = json['type'];
    city = json['city'];
    edate = json['edate'];
    page = json['page'];
    keywords = json['keywords'];
    sdate = json['sdate'];
    category = json['category'];
    cityDisplay = json['city_display'];
    rows = json['rows'];
  }

  Request copyWith({
    String? venue,
    String? ids,
    String? type,
    String? city,
    num? edate,
    num? page,
    String? keywords,
    num? sdate,
    String? category,
    String? cityDisplay,
    num? rows,
  }) {
    return Request(
      venue: venue ?? this.venue,
      ids: ids ?? this.ids,
      type: type ?? this.type,
      city: city ?? this.city,
      edate: edate ?? this.edate,
      page: page ?? this.page,
      keywords: keywords ?? this.keywords,
      sdate: sdate ?? this.sdate,
      category: category ?? this.category,
      cityDisplay: cityDisplay ?? this.cityDisplay,
      rows: rows ?? this.rows,
    );
  }
}

class Item {
  String? eventId;
  String? eventname;
  String? eventnameRaw;
  String? ownerId;
  String? thumbUrl;
  String? thumbUrlLarge;
  int? startTime;
  String? startTimeDisplay;
  num? endTime;
  String? endTimeDisplay;
  String? location;
  Venue? venue;
  String? label;
  num? featured;
  String? eventUrl;
  String? shareUrl;
  String? bannerUrl;
  num? score;
  List<String>? categories;
  List<String>? tags;
  Tickets? tickets;
  List<dynamic>? customParams;

  Item(
      {this.eventId,
      this.eventname,
      this.eventnameRaw,
      this.ownerId,
      this.thumbUrl,
      this.thumbUrlLarge,
      this.startTime,
      this.startTimeDisplay,
      this.endTime,
      this.endTimeDisplay,
      this.location,
      this.venue,
      this.label,
      this.featured,
      this.eventUrl,
      this.shareUrl,
      this.bannerUrl,
      this.score,
      this.categories,
      this.tags,
      this.tickets,
      this.customParams});

  Item.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventname = json['eventname'];
    eventnameRaw = json['eventname_raw'];
    ownerId = json['owner_id'];
    thumbUrl = json['thumb_url'];
    thumbUrlLarge = json['thumb_url_large'];
    startTime = json['start_time'];
    startTimeDisplay = json['start_time_display'];
    endTime = json['end_time'];
    endTimeDisplay = json['end_time_display'];
    location = json['location'];
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    label = json['label'];
    featured = json['featured'];
    eventUrl = json['event_url'];
    shareUrl = json['share_url'];
    bannerUrl = json['banner_url'];
    score = json['score'];
    categories = (json['categories'] as List<dynamic>?)?.cast<String>();
    tags = (json['tags'] as List<dynamic>?)?.cast<String>();
    tickets =
        json['tickets'] != null ? Tickets.fromJson(json['tickets']) : null;
    customParams = json['custom_params'] as List<dynamic>?;
  }

  Item copyWith({
    String? eventId,
    String? eventname,
    String? eventnameRaw,
    String? ownerId,
    String? thumbUrl,
    String? thumbUrlLarge,
    int? startTime,
    String? startTimeDisplay,
    num? endTime,
    String? endTimeDisplay,
    String? location,
    Venue? venue,
    String? label,
    num? featured,
    String? eventUrl,
    String? shareUrl,
    String? bannerUrl,
    num? score,
    List<String>? categories,
    List<String>? tags,
    Tickets? tickets,
    List<dynamic>? customParams,
  }) {
    return Item(
      eventId: eventId ?? this.eventId,
      eventname: eventname ?? this.eventname,
      eventnameRaw: eventnameRaw ?? this.eventnameRaw,
      ownerId: ownerId ?? this.ownerId,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      thumbUrlLarge: thumbUrlLarge ?? this.thumbUrlLarge,
      startTime: startTime ?? this.startTime,
      startTimeDisplay: startTimeDisplay ?? this.startTimeDisplay,
      endTime: endTime ?? this.endTime,
      endTimeDisplay: endTimeDisplay ?? this.endTimeDisplay,
      location: location ?? this.location,
      venue: venue ?? this.venue,
      label: label ?? this.label,
      featured: featured ?? this.featured,
      eventUrl: eventUrl ?? this.eventUrl,
      shareUrl: shareUrl ?? this.shareUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      score: score ?? this.score,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      tickets: tickets ?? this.tickets,
      customParams: customParams ?? this.customParams,
    );
  }
}

class Venue {
  String? street;
  String? city;
  String? state;
  String? country;
  num? latitude;
  num? longitude;
  String? fullAddress;

  Venue(
      {this.street,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.fullAddress});

  Venue.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    fullAddress = json['full_address'];
  }

  Venue copyWith({
    String? street,
    String? city,
    String? state,
    String? country,
    num? latitude,
    num? longitude,
    String? fullAddress,
  }) {
    return Venue(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }
}

class Tickets {
  bool? hasTickets;
  String? ticketUrl;
  String? ticketCurrency;
  num? mnumicketPrice;
  num? maxTicketPrice;

  Tickets(
      {this.hasTickets,
      this.ticketUrl,
      this.ticketCurrency,
      this.mnumicketPrice,
      this.maxTicketPrice});

  Tickets.fromJson(Map<String, dynamic> json) {
    hasTickets = json['has_tickets'];
    ticketUrl = json['ticket_url'];
    ticketCurrency = json['ticket_currency'];
    mnumicketPrice = json['min_ticket_price'];
    maxTicketPrice = json['max_ticket_price'];
  }

  Tickets copyWith({
    bool? hasTickets,
    String? ticketUrl,
    String? ticketCurrency,
    num? mnumicketPrice,
    num? maxTicketPrice,
  }) {
    return Tickets(
      hasTickets: hasTickets ?? this.hasTickets,
      ticketUrl: ticketUrl ?? this.ticketUrl,
      ticketCurrency: ticketCurrency ?? this.ticketCurrency,
      mnumicketPrice: mnumicketPrice ?? this.mnumicketPrice,
      maxTicketPrice: maxTicketPrice ?? this.maxTicketPrice,
    );
  }
}
