/// Enum for HTTP Status Codes
enum HttpStatusCodes {
  ok_200(200, 'OK'),

  badRequest_400(400, 'Bad Request'),
  unauthorized_401(401, 'Unauthorized'),
  forbidden_403(403, 'Forbidden'),
  notFound_404(404, 'Not Found'),
  methodNotAllowed_405(405, 'Method Not Allowed'),
  requestTimeout_408(408, 'Request Timeout');

  final int code;
  final String description;

  const HttpStatusCodes(this.code, this.description);

  static HttpStatusCodes? fromCode(int code) {
    for (HttpStatusCodes status in HttpStatusCodes.values) {
      if (status.code == code) return status;
    }
    return null;
  }

  @override
  String toString() {
    return '$code: $description';
  }
}
