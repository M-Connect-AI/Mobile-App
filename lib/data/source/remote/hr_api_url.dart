String normalizeHrApiBaseUrl(String baseUrl) {
  final normalized = baseUrl.replaceFirst(RegExp(r'/$'), '');
  final uri = Uri.tryParse(normalized);
  if (uri == null || uri.path.endsWith('/api/hr') || uri.port == 3002) {
    return normalized;
  }
  return '$normalized/api/hr';
}
