import os

code = """import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const RedHerramientasApp());
}

class AppColors {
  static const Color backgroundMain = Color(0xFFFAFAFA);
  static const Color textMain = Color(0xFF1A1A1A);
  static const Color dominant = Color(0xFFC77986); // Rosa pastel oscuro
  static const Color accent = Color(0xFFD95D39); // Terracota cálido
  static const Color backgroundSecondary = Color(0xFFE9ECEF);
  static const Color separatorBar = Color(0xFFFF007F);
  static const Color mustardDonate = Color(0xFFFFDB58);
}

class RedHerramientasApp extends StatefulWidget {
  const RedHerramientasApp({super.key});

  @override
  State<RedHerramientasApp> createState() => _RedHerramientasAppState();
}

class _RedHerramientasAppState extends State<RedHerramientasApp> {
  double _textScale = 1.0;

  void _increaseFont() => setState(() => _textScale = (_textScale + 0.1).clamp(0.8, 2.0));
  void _decreaseFont() => setState(() => _textScale = (_textScale - 0.1).clamp(0.8, 2.0));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red de Herramientas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundMain,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dominant, background: AppColors.backgroundMain),
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodyLarge: const TextStyle(fontSize: 20, color: AppColors.textMain, height: 1.5),
          bodyMedium: const TextStyle(fontSize: 18, color: AppColors.textMain, height: 1.5),
          titleLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.dominant),
          headlineMedium: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: AppColors.textMain),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
          ),
        ),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(_textScale)),
          child: child!,
        );
      },
      home: LandingPage(
        onIncreaseFont: _increaseFont,
        onDecreaseFont: _decreaseFont,
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  final VoidCallback onIncreaseFont;
  final VoidCallback onDecreaseFont;

  const LandingPage({super.key, required this.onIncreaseFont, required this.onDecreaseFont});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  
  final GlobalKey _inicioKey = GlobalKey();
  final GlobalKey _quienesSomosKey = GlobalKey();
  final GlobalKey _actividadesKey = GlobalKey();
  final GlobalKey _recursosKey = GlobalKey();
  final GlobalKey _contactoKey = GlobalKey();

  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, GlobalKey> _searchKeywords = {};

  @override
  void initState() {
    super.initState();
    _searchKeywords['inicio'] = _inicioKey;
    _searchKeywords['somos'] = _quienesSomosKey;
    _searchKeywords['quienes'] = _quienesSomosKey;
    _searchKeywords['actividades'] = _actividadesKey;
    _searchKeywords['ejes'] = _actividadesKey;
    _searchKeywords['recursos'] = _recursosKey;
    _searchKeywords['contacto'] = _contactoKey;
    _searchKeywords['donar'] = _contactoKey;
  }

  void _scrollToKey(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _performSearch(String query) {
    String q = query.toLowerCase().trim();
    for (var k in _searchKeywords.keys) {
      if (q.contains(k)) {
        _scrollToKey(_searchKeywords[k]!);
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No se encontró sección para: $query')),
    );
  }

  void _launchWhatsApp() async {
    final url = Uri.parse('https://wa.me/5491122766776');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: _buildAppBar(context, isDesktop),
      drawer: !isDesktop ? _buildDrawer(context) : null,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'whatsapp',
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: _launchWhatsApp,
            child: ClipOval(
              child: Image.asset('assets/whatsapp.png', width: 55, height: 55, fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.chat, color: Colors.green, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'scroll_top',
            backgroundColor: AppColors.dominant.withOpacity(0.6),
            elevation: 0,
            onPressed: () => _scrollToKey(_inicioKey),
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(key: _inicioKey, width: double.infinity, color: AppColors.separatorBar, height: 20),
            
            // Header
            if (isDesktop) _buildDesktopNav(),

            // Carrusel Full Width
            const FullWidthCarousel(),

            // Ejes Full Width
            Container(key: _actividadesKey, child: const EjesSection()),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(key: _contactoKey, child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDesktop) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 90,
      iconTheme: const IconThemeData(color: AppColors.dominant, size: 36),
      title: Image.network('https://i.imgur.com/CFM0Pcr.png', height: 60, fit: BoxFit.contain),
      actions: [
        IconButton(
          icon: const Text("A-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dominant)),
          onPressed: widget.onDecreaseFont,
        ),
        IconButton(
          icon: const Text("A+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dominant)),
          onPressed: widget.onIncreaseFont,
        ),
        // Buscador Animado
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSearchExpanded ? (isDesktop ? 300 : 200) : 50,
            height: 50,
            decoration: BoxDecoration(
              color: _isSearchExpanded ? Colors.grey.shade100 : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 16, top: 0, bottom: 0, right: 50,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isSearchExpanded ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !_isSearchExpanded,
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(hintText: 'Buscar...', border: InputBorder.none, isDense: true),
                          onSubmitted: _performSearch,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0, top: 0, bottom: 0,
                  child: IconButton(
                    iconSize: 28,
                    icon: Icon(_isSearchExpanded ? Icons.close : Icons.search),
                    color: AppColors.dominant,
                    onPressed: () {
                      setState(() {
                        _isSearchExpanded = !_isSearchExpanded;
                        if (!_isSearchExpanded) _searchController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isDesktop) const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildDesktopNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _navLink("Inicio", _inicioKey),
          _navLink("Quiénes somos", _quienesSomosKey),
          _navLink("Actividades", _actividadesKey),
          _navLink("Recursos", _recursosKey),
          _navLink("Contacto", _contactoKey),
        ],
      ),
    );
  }

  Widget _navLink(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () => _scrollToKey(key),
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Center(child: Image.network('https://i.imgur.com/CFM0Pcr.png', fit: BoxFit.contain)),
          ),
          _drawerItem("Inicio", _inicioKey),
          _drawerItem("Quiénes somos", _quienesSomosKey),
          _drawerItem("Actividades", _actividadesKey),
          _drawerItem("Recursos", _recursosKey),
          _drawerItem("Contacto", _contactoKey),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain)),
      onTap: () {
        Navigator.pop(context);
        _scrollToKey(key);
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 7, child: _buildMainContent()),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _buildSidebar()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildMainContent(),
        const SizedBox(height: 60),
        _buildSidebar(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(key: _quienesSomosKey, child: const QuienesSomosSection()),
        const SizedBox(height: 60),
        Container(key: _recursosKey, child: const RecursosSection()),
      ],
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Text("Apoyá nuestro espacio", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Container(width: 120, height: 120, color: Colors.black12, child: const Icon(Icons.qr_code, size: 80, color: Colors.black87)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.volunteer_activism, size: 28),
                label: const Text("DONAR"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mustardDonate, foregroundColor: AppColors.textMain,
                  minimumSize: const Size(double.infinity, 80), textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundSecondary,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, size: 40, color: Colors.blue),
                onPressed: () => launchUrl(Uri.parse('https://www.facebook.com/share/1RiPWewXqR/')),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 40, color: Colors.purple), // Instagram icon approx
                onPressed: () => launchUrl(Uri.parse('https://www.instagram.com/redherramientas?stkn=MW01cnN1eHlheHExMA==')),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 40, color: Colors.red),
                onPressed: () => launchUrl(Uri.parse('https://youtube.com/@reddeherramientasentremujeres?si=X0ZCFkMKebH4L3lk')),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Red de Herramientas Entre Mujeres © 2026", style: TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }
}

// ==========================================
// SECTIONS
// ==========================================

class FullWidthCarousel extends StatefulWidget {
  const FullWidthCarousel({super.key});

  @override
  State<FullWidthCarousel> createState() => _FullWidthCarouselState();
}

class _FullWidthCarouselState extends State<FullWidthCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> slides = [
    {
      "title": "Enredos de Película",
      "img": "https://images.unsplash.com/photo-1518932945647-7a3c9692482c?q=80&w=1600",
      "desc": "Ciclo de cine debate para personas mayores, compartiendo reflexiones y cultura. Un espacio para el encuentro y la construcción colectiva.",
      "url": "https://www.redherramientas.com"
    },
    {
      "title": "Clic Seguro en RED",
      "img": "https://images.unsplash.com/photo-1573164713988-8665fc963095?q=80&w=1600",
      "desc": "Tecnología, seguridad digital e inteligencia artificial. Reducimos la brecha digital aprendiendo a utilizar el celular y evitar estafas virtuales de forma autónoma.",
      "url": "https://www.redherramientas.com"
    }
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
      if (_currentPage < slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            itemCount: slides.length,
            itemBuilder: (context, index) {
              return CarouselSlide(data: slides[index]);
            },
          ),
          Positioned(
            left: 20, top: 0, bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
                onPressed: () {
                  if (_currentPage > 0) _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                },
              ),
            ),
          ),
          Positioned(
            right: 20, top: 0, bottom: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 40),
                onPressed: () {
                  if (_currentPage < slides.length - 1) _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselSlide extends StatefulWidget {
  final Map<String, String> data;
  const CarouselSlide({super.key, required this.data});

  @override
  State<CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.data['url']!)),
          child: Image.network(widget.data['img']!, fit: BoxFit.cover),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.bottomCenter, end: Alignment.topCenter,
            )
          ),
        ),
        Positioned(
          bottom: 60, left: 80, right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data['title']!, style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              AnimatedCrossFade(
                firstChild: Text(
                  widget.data['desc']!,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data['desc']!, style: const TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => launchUrl(Uri.parse(widget.data['url']!)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.dominant),
                      child: const Text("Ir a la publicación", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
                crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                child: Text(_expanded ? "Ver menos" : "Ver más", style: const TextStyle(color: AppColors.mustardDonate, fontSize: 18)),
              )
            ],
          ),
        )
      ],
    );
  }
}

class EjesSection extends StatelessWidget {
  const EjesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ejes = [
      {"icon": "🌿", "title": "Salud y Bienestar"},
      {"icon": "🎭", "title": "Educación y Cultura"},
      {"icon": "⚖️", "title": "Derechos"},
      {"icon": "🌱", "title": "Medio Ambiente"},
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          Text("Nuestros Ejes", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          const Text("Cuatro grandes temas para encontrar rápido lo que buscás.", style: TextStyle(fontSize: 20, color: Colors.black54)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20, runSpacing: 20, alignment: WrapAlignment.center,
            children: ejes.map((e) => Container(
              width: 250, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppColors.backgroundMain, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  Text(e["icon"]!, style: const TextStyle(fontSize: 50)),
                  const SizedBox(height: 16),
                  Text(e["title"]!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.dominant), textAlign: TextAlign.center),
                ],
              ),
            )).toList(),
          )
        ],
      ),
    );
  }
}

class QuienesSomosSection extends StatelessWidget {
  const QuienesSomosSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("¿Qué es #ClicSeguroEnRED?", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        Text("Un espacio impulsado por Red de Herramientas entre Mujeres para reducir la brecha digital y la de usabilidad, para promover el uso seguro y autónomo de la tecnología entre personas mayores.", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        Text("Los facilitadores, docentes de tecnología, somos también mujeres mayores, lo que conlleva la empatía necesaria para generar el clima de seguridad y confianza...", style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class RecursosSection extends StatelessWidget {
  const RecursosSection({super.key});
  @override
  Widget build(BuildContext context) {
    final resources = [
      "Cómo detectar estafas", "Configuraciones de accesibilidad", "Uso seguro de WhatsApp", "Tutoriales paso a paso"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recursos destacados", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16, runSpacing: 16,
          children: resources.map((res) => Chip(
            label: Text(res, style: const TextStyle(color: Colors.white, fontSize: 16)),
            backgroundColor: AppColors.dominant,
            padding: const EdgeInsets.all(12),
          )).toList(),
        ),
      ],
    );
  }
}
"""

with open("lib/main.dart", "w", encoding="utf-8") as f:
    f.write(code)
print("done")
