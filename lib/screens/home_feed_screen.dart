import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import '../widgets/bottom_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFeedScreen extends StatefulWidget {
  final Function(String)? onNavigate;

  const HomeFeedScreen({super.key, this.onNavigate});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> _articles = [];
  bool _isLoading = false;
  bool _isInitialLoading = true;
  int _currentPage = 0;
  final int _pageSize = 5; // Number of articles per load
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
    _scrollController.removeListener(_onScroll); // <-- Add this line
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch initial set of articles with randomization for freshness
  Future<void> _fetchInitialArticles() async {
    if (!mounted) return;
    setState(() {
      _isInitialLoading = true;
      _articles.clear();
      _currentPage = 0;
    });

    try {
      final random = Random();
      final selectedQuery = _searchQueries[random.nextInt(_searchQueries.length)];
      final results = await _searchGoogle(selectedQuery['query']!, int.parse(selectedQuery['num_results']!));
      final newArticles = _parseSearchResults(results);

      if (!mounted) return;
      setState(() {
        _articles.addAll(
          newArticles.map((e) => e.map((k, v) => MapEntry(k, v.toString())))
        );
        _isInitialLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching initial articles: $e');
      if (mounted) {
        setState(() {
          _isInitialLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load recommendations: $e')),
        );
      }
    }
  }

  // Load more articles on scroll
  Future<void> _loadMoreArticles() async {
    if (_isLoading) return;

    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final random = Random();
      final selectedQuery = _searchQueries[random.nextInt(_searchQueries.length)];
      final results = await _searchGoogle(selectedQuery['query']!, _pageSize);
      final newArticles = _parseSearchResults(results);

      if (!mounted) return;
      if (newArticles.isNotEmpty) {
        setState(() {
          _articles.addAll(
            newArticles.map((e) => e.map((k, v) => MapEntry(k, v.toString())))
          );
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading more articles: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load more articles: $e')),
        );
      }
    }
  }

  // Simulate Google Custom Search API call (replace with actual API key and CX)
  Future<List<dynamic>> _searchGoogle(String query, int numResults) async {
    const apiKey = 'AIzaSyBHZW3DF6fMJ8nC2Jj2ng7iLl2B7XXW9YM';
    const cx = '3175592874fc14236';
    final url = Uri.parse('https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=${Uri.encodeComponent(query)}&num=$numResults');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)['items'] ?? [];
    } else {
      throw Exception('Failed to search: ${response.statusCode}');
    }
  }

  // Parse search results into a simple map
  List<Map<String, dynamic>> _parseSearchResults(List<dynamic> items) {
    return items.map((item) {
      final displayLink = item['displayLink'] ?? '';
      final imageUrl = displayLink.isNotEmpty
          ? 'https://logo.clearbit.com/$displayLink'
          : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png';
      return {
        'title': item['title'] ?? 'Untitled Article',
        'source': displayLink.isNotEmpty ? displayLink : 'Unknown Source',
        'imageUrl': imageUrl,
        'link': item['link'] ?? '',
      };
    }).toList();
  }

  // Scroll listener for infinite loading
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreArticles();
    }
  }

  // Open article in external browser (implement with url_launcher package)
  void _openArticle(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the article.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background white container (fills available space below the header and above the nav bar)
            Positioned(
              left: 0,
              top: 155,
              right: 0,
              bottom: 80, // Leaves space for the navigation bar
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 100), // Extra bottom padding for nav bar & loader
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      if (_isInitialLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (_articles.isEmpty)
                        const Center(child: Text('No articles found'))
                      else
                        ..._articles.map((article) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildArticleCard(
                            title: article['title']!,
                            source: article['source']!,
                            imageUrl: article['imageUrl']!,
                            onTap: () => _openArticle(article['link']!),
                          ),
                        ),).toList(),
                    ],
                  ),
                ),
              ),
            ),

            // Title
            Positioned(
              left: 28,
              top: 108,
              child: Text(
                'Your Feed',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
            ),

            // Bottom Navigation
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavigationBar(
                currentIndex: 0,
                onNavigate: widget.onNavigate,
              ),
            ),

            // Loading indicator at the bottom center when loading more articles
            if (_isLoading && !_isInitialLoading)
              Positioned(
                left: 0,
                right: 0,
                bottom: 80, // Above the navigation bar
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String source,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    source,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      letterSpacing: 0.024,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}