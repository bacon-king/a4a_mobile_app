import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class HIVRecommendationsScreen extends StatefulWidget {
  final Function(String) onNavigate;

  const HIVRecommendationsScreen({super.key, required this.onNavigate});

  @override
  State<HIVRecommendationsScreen> createState() => _HIVRecommendationsScreenState();
}

class _HIVRecommendationsScreenState extends State<HIVRecommendationsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Article> _articles = [];
  bool _isLoading = false;
  bool _isInitialLoading = true;
  int _currentPage = 0;
  final int _pageSize = 5; // Smaller page size for dynamic feel
  static const List<Map<String, String>> _searchQueries = [
    {'query': 'HIV AIDS articles', 'num_results': '10'},
    {'query': 'latest HIV research', 'num_results': '10'},
    {'query': 'HIV prevention strategies', 'num_results': '10'},
    {'query': 'AIDS treatment advances', 'num_results': '10'},
    {'query': 'HIV awareness education', 'num_results': '10'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchInitialArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch initial set of articles with randomization for freshness
  Future<void> _fetchInitialArticles() async {
    setState(() {
      _isInitialLoading = true;
      _articles.clear();
      _currentPage = 0;
    });

    try {
      // Randomize query selection for variety each time
      final random = Random();
      final selectedQuery = _searchQueries[random.nextInt(_searchQueries.length)];
      final results = await _searchGoogle(selectedQuery['query']!, int.parse(selectedQuery['num_results']!));
      final articles = _parseSearchResults(results);
      
      setState(() {
        _articles.addAll(articles);
        _isInitialLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching initial articles: $e');
      setState(() {
        _isInitialLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load recommendations: $e')),
      );
    }
  }

  // Load more articles on scroll
  Future<void> _loadMoreArticles() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Use a different query for variety
      final random = Random();
      final selectedQuery = _searchQueries[random.nextInt(_searchQueries.length)];
      final results = await _searchGoogle(selectedQuery['query']!, _pageSize);
      final newArticles = _parseSearchResults(results);
      
      if (newArticles.isNotEmpty) {
        setState(() {
          _articles.addAll(newArticles);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading more articles: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load more articles: $e')),
      );
    }
  }

  // Simulate Google Custom Search API call (replace with actual API key and CX)
  // For now, using mock data based on real search results; in production, use http to call:
  // https://www.googleapis.com/customsearch/v1?key=YOUR_API_KEY&cx=YOUR_CX&q=${Uri.encodeComponent(query)}&num=$numResults
  Future<List<dynamic>> _searchGoogle(String query, int numResults) async {
    const apiKey = 'AIzaSyBHZW3DF6fMJ8nC2Jj2ng7iLl2B7XXW9YM'; // Placeholder
    const cx = 'https://cse.google.com/cse.js?cx=3175592874fc14236'; // Placeholder
    final url = Uri.parse('https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=${Uri.encodeComponent(query)}&num=$numResults');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)['items'] ?? [];
    } else {
      throw Exception('Failed to search: ${response.statusCode}');
    }
  }

  // Parse search results into Article models
  List<Article> _parseSearchResults(List<dynamic> items) {
    return items.map((item) => Article(
      id: DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000).toString(), // Unique ID
      title: item['title'] ?? 'Untitled Article',
      description: item['snippet'] ?? 'No description available.',
      url: item['link'] ?? '',
      source: item['displayLink'] ?? 'Unknown Source',
      date: DateTime.now(), // Approximate date
    )).toList();
  }

  // Scroll listener for infinite loading
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreArticles();
    }
  }

  // Open article in external browser (implement with url_launcher package)
  void _openArticle(String url) {
    // TODO: Use url_launcher to open URL
    debugPrint('Opening article: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Your Feed',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () => widget.onNavigate('notifications'), // Assuming navigation to notifications
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isInitialLoading
                ? const Center(child: CircularProgressIndicator())
                : _articles.isEmpty
                    ? const Center(child: Text('No articles found'))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _articles.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _articles.length) {
                            return const Center(child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ));
                          }
                          final article = _articles[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () => _openArticle(article.url),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Placeholder image (add Image.network if imageUrl available)
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.article_outlined, size: 50, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      article.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      article.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          article.source,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${article.date.day}/${article.date.month}/${article.date.year}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          // Bottom navigation bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home_outlined),
                  onPressed: () => widget.onNavigate('home'),
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.article_outlined),
                  onPressed: () => widget.onNavigate('feed'), // Current page
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () => widget.onNavigate('calendar'),
                  color: Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.person_outlined),
                  onPressed: () => widget.onNavigate('profile'),
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}