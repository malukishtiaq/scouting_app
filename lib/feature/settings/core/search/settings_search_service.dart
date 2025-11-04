/// Search result item
class SearchResultItem {
  final String id;
  final String title;
  final String? description;
  final SearchResultType type;
  final double relevanceScore;
  final String? category;
  final String? route;
  final Map<String, dynamic> metadata;

  const SearchResultItem({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.relevanceScore,
    this.category,
    this.route,
    this.metadata = const {},
  });
}

/// Search result types
enum SearchResultType { feature, setting }

/// Search filters
class SearchFilters {
  final List<String> categories;
  final List<SearchResultType> types;
  final bool? requiresAuth;
  final DateTimeRange? dateRange;

  const SearchFilters({
    this.categories = const [],
    this.types = const [],
    this.requiresAuth,
    this.dateRange,
  });

  /// Check if filters are empty
  bool get isEmpty =>
      categories.isEmpty &&
      types.isEmpty &&
      requiresAuth == null &&
      dateRange == null;
}

/// Search sort options
enum SearchSortOption { relevance, title, category, type, recent }

/// Search results
class SearchResult {
  final String query;
  final List<SearchResultItem> results;
  final int totalResults;
  final SearchFilters filters;
  final SearchSortOption sortBy;
  final String? error;

  const SearchResult({
    required this.query,
    required this.results,
    required this.totalResults,
    required this.filters,
    required this.sortBy,
    this.error,
  });

  /// Check if search was successful
  bool get isSuccess => error == null;
}

/// Date time range for search filters
class DateTimeRange {
  final DateTime start;
  final DateTime end;

  const DateTimeRange({required this.start, required this.end});

  /// Check if date is within range
  bool contains(DateTime date) {
    return date.isAfter(start) && date.isBefore(end);
  }
}

/// Basic search service for settings
class SettingsSearchService {
  /// Search settings
  Future<SearchResult> searchSettings(
    String query, {
    SearchFilters? filters,
    SearchSortOption sortBy = SearchSortOption.relevance,
    int maxResults = 100,
  }) async {
    // Basic implementation - in a real app, this would search through actual data
    if (query.trim().isEmpty) {
      return SearchResult(
        query: query,
        results: [],
        totalResults: 0,
        filters: filters ?? const SearchFilters(),
        sortBy: sortBy,
      );
    }

    // Mock search results for now
    final mockResults = [
      SearchResultItem(
        id: 'notifications',
        title: 'Notifications',
        description: 'Manage notification preferences',
        type: SearchResultType.setting,
        relevanceScore: 10.0,
        category: 'General',
        route: '/settings/notifications',
      ),
      SearchResultItem(
        id: 'privacy',
        title: 'Privacy',
        description: 'Control your privacy settings',
        type: SearchResultType.setting,
        relevanceScore: 9.0,
        category: 'Security',
        route: '/settings/privacy',
      ),
      SearchResultItem(
        id: 'theme',
        title: 'Theme',
        description: 'Customize app appearance',
        type: SearchResultType.setting,
        relevanceScore: 8.0,
        category: 'Appearance',
        route: '/settings/theme',
      ),
    ];

    // Filter results based on query
    final filteredResults = mockResults
        .where((item) =>
            item.title.toLowerCase().contains(query.toLowerCase()) ||
            (item.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();

    // Sort results
    final sortedResults = _sortResults(filteredResults, sortBy);

    // Limit results
    final limitedResults = sortedResults.take(maxResults).toList();

    return SearchResult(
      query: query,
      results: limitedResults,
      totalResults: limitedResults.length,
      filters: filters ?? const SearchFilters(),
      sortBy: sortBy,
    );
  }

  /// Sort search results
  List<SearchResultItem> _sortResults(
    List<SearchResultItem> results,
    SearchSortOption sortBy,
  ) {
    final sortedResults = List<SearchResultItem>.from(results);

    switch (sortBy) {
      case SearchSortOption.relevance:
        sortedResults.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
        break;
      case SearchSortOption.title:
        sortedResults.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SearchSortOption.category:
        sortedResults.sort((a, b) {
          final categoryA = a.category ?? '';
          final categoryB = b.category ?? '';
          return categoryA.toLowerCase().compareTo(categoryB.toLowerCase());
        });
        break;
      case SearchSortOption.type:
        sortedResults.sort((a, b) => a.type.index.compareTo(b.type.index));
        break;
      case SearchSortOption.recent:
        // For now, keep original order
        break;
    }

    return sortedResults;
  }

  /// Get search suggestions
  Future<List<String>> getSearchSuggestions(
    String query, {
    int maxSuggestions = 10,
  }) async {
    if (query.trim().isEmpty) return [];

    // Mock suggestions
    final suggestions = [
      'notifications',
      'privacy',
      'theme',
      'security',
      'language',
      'font size',
      'time format',
      'date format',
      'profile visibility',
      'online status',
    ];

    // Filter suggestions based on query
    final filteredSuggestions = suggestions
        .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredSuggestions.take(maxSuggestions).toList();
  }

  /// Get popular search terms
  Future<List<String>> getPopularSearchTerms() async {
    // Mock popular terms
    return [
      'notifications',
      'privacy',
      'theme',
      'security',
      'language',
    ];
  }

  /// Save search query to history
  Future<void> saveSearchQuery(String query) async {
    // In a real app, this would save to local storage or database
    print('Search query saved: $query');
  }

  /// Get search history
  Future<List<String>> getSearchHistory() async {
    // Mock search history
    return [
      'notifications',
      'privacy settings',
      'theme customization',
    ];
  }

  /// Clear search history
  Future<void> clearSearchHistory() async {
    // In a real app, this would clear local storage or database
    print('Search history cleared');
  }
}
