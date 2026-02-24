// onboarding_view.dart
import 'package:flutter/material.dart';
import 'package:logbook_app_001/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  // Data untuk setiap halaman onboarding
  final List<Map<String, dynamic>> _pages = [
    {
      'image': 'assets/images/onboarding_1.jpg', // Sesuai dengan file
      'icon': Icons.edit_note, // Fallback jika gambar tidak ada
      'color': Colors.blue,
      'title': '"You are my best friend, bud"', // ← EDIT TEXT INI
      'description':
          '-How to Train Your Dragon: The Hidden World-', // ← EDIT TEXT INI
    },
    {
      'image': 'assets/images/onboarding_2.jpg', // Sesuai dengan file
      'icon': Icons.trending_up, // Fallback jika gambar tidak ada
      'color': Colors.green,
      'title': '"I love you in every universe"', // ← EDIT TEXT INI
      'description':
          '-Doctor Strange in the Multiverse of Madness-', // ← EDIT TEXT INI
    },
    {
      'image':
          'assets/images/onboarding_3.jpg', // Sesuai dengan file (bukan jpeg)
      'icon': Icons.cloud_done, // Fallback jika gambar tidak ada
      'color': Colors.purple,
      'title': '“Shinzou wo Sasageyo!”', // ← EDIT TEXT INI
      'description': '-Attack on Titan-', // ← EDIT TEXT INI
    },
  ];

  void _handleNext() {
    if (currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Selamat Datang"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // PageView untuk slide onboarding
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Gambar atau Icon (fallback) dengan ukuran seragam
                        Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: _pages[index]['image'] != null
                                ? Image.asset(
                                    _pages[index]['image'],
                                    width: 260,
                                    height: 260,
                                    fit:
                                        BoxFit.cover, // Cover untuk ukuran sama
                                    errorBuilder: (context, error, stackTrace) {
                                      // Jika gambar tidak ditemukan, tampilkan icon
                                      return Container(
                                        color: _pages[index]['color']
                                            .withOpacity(0.1),
                                        child: Icon(
                                          _pages[index]['icon'],
                                          size: 100,
                                          color: _pages[index]['color'],
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: _pages[index]['color'].withOpacity(
                                      0.1,
                                    ),
                                    child: Icon(
                                      _pages[index]['icon'],
                                      size: 100,
                                      color: _pages[index]['color'],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Quotes (di atas, gede)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            _pages[index]['title'], // Ini quotes
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Judul Film (di bawah, kecil, 1 baris)
                        Text(
                          _pages[index]['description'], // Ini judul film
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Page Indicator (titik-titik)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Tombol Next
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleNext,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  currentPage == _pages.length - 1 ? 'Mulai' : 'Lanjut',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
