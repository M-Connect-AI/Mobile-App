String normalizeAgentApiBaseUrl(String baseUrl) {
  final normalized = baseUrl.replaceFirst(RegExp(r'/$'), '');
  final uri = Uri.tryParse(normalized);
  if (uri == null || uri.path.endsWith('/api/agent') || uri.port == 3001) {
    return normalized;
  }
  return '$normalized/api/agent';
}
