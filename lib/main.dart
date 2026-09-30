import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const RedHerramientasApp());
}

class AppColors {
  static const Color dominant = Color(0xFFC77986);
  static const Color backgroundLight = Color(0xFFFAF9F6);
  static const Color backgroundSecondary = Color(0xFFEFEFEF);
  static const Color textMain = Color(0xFF2C2C2C);
  static const Color accent = Color(0xFFE5A9A9);
  static const Color separatorBar = Color(0xFFB56A75);
  static const Color mustardDonate = Color(0xFFE4C563);
}

class RedHerramientasApp extends StatefulWidget {
  const RedHerramientasApp({super.key});

  @override
  State<RedHerramientasApp> createState() => _RedHerramientasAppState();
}

class _RedHerramientasAppState extends State<RedHerramientasApp> {
  double _textScale = 1.0;

  void _setFontScale(double scale) {
    setState(() {
      _textScale = scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red de Herramientas Entre Mujeres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dominant),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_textScale),
          ),
          child: child!,
        );
      },
      home: LandingPage(
        onSetFontScale: _setFontScale,
        currentScale: _textScale,
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  final Function(double) onSetFontScale;
  final double currentScale;

  const LandingPage({
    super.key, 
    required this.onSetFontScale,
    required this.currentScale,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey _inicioKey = GlobalKey();
  final GlobalKey _quienesSomosKey = GlobalKey();
  final GlobalKey _actividadesKey = GlobalKey();
  final GlobalKey _propuestasKey = GlobalKey();
  final GlobalKey _recursosKey = GlobalKey();
  final GlobalKey _contactoKey = GlobalKey();
  final GlobalKey _donateKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchExpanded = false;

  final Map<String, GlobalKey> _searchKeywords = {};

  @override
  void initState() {
    super.initState();
    _searchKeywords['inicio'] = _inicioKey;
    _searchKeywords['quienes'] = _quienesSomosKey;
    _searchKeywords['somos'] = _contactoKey;
    _searchKeywords['actividades'] = _propuestasKey;
    _searchKeywords['recursos'] = _recursosKey;
    _searchKeywords['contacto'] = _contactoKey;
    _searchKeywords['donar'] = _donateKey;
    _searchKeywords['ejes'] = _actividadesKey;
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        // Obtenemos la posicion global del widget
        final position = box.localToGlobal(Offset.zero).dy;
        // La altura de la pantalla
        final screenHeight = MediaQuery.of(context).size.height;
        // Calculamos el target
        double target = _scrollController.offset + position - 80; // 80 de margen
        
        // No pasarse del inicio ni del final
        target = target.clamp(0.0, _scrollController.position.maxScrollExtent);
        
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _handleSearch(String query) {
    final lowerQuery = query.toLowerCase().trim();
    for (final entry in _searchKeywords.entries) {
      if (lowerQuery.contains(entry.key)) {
        _scrollToKey(entry.value);
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se encontraron resultados para esa búsqueda.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: _buildAppBar(isDesktop, context),
      drawer: isDesktop ? null : _buildDrawer(context),
            floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'whatsapp',
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () => launchUrl(Uri.parse('https://wa.me/5491122766776')),
            child: ClipOval(
              child: Image.asset(
                'assets/whatsapp.png',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),
          FloatingActionButton(
            heroTag: 'scroll_top',
            backgroundColor: AppColors.dominant.withOpacity(0.6),
            elevation: 0,
            onPressed: () {
              _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Top Nav on Desktop
            if (isDesktop)
              Container(
                key: _inicioKey,
                width: double.infinity,
                color: AppColors.dominant,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _navItem("Inicio", () => _scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut)),
                    _navItem("Quiénes somos", () => _scrollToKey(_contactoKey)), 
                    _navItem("Actividades", () => _scrollToKey(_propuestasKey)),
                    _navItem("Recursos", () => _scrollToKey(_recursosKey)),
                    _navItem("Contacto", () => _scrollToKey(_contactoKey)),
                  ],
                ),
              ),
            
            // Hero / Carousel Full Width
            HeroSection(key: _quienesSomosKey),
            _buildSeparator(isMobile: !isDesktop),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
            ),
            
            // Footer
            Container(key: _contactoKey, child: _buildFooter(isDesktop)),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDesktop, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 90,
      iconTheme: const IconThemeData(color: AppColors.dominant, size: 36),
      title: Image.network(
        'https://i.imgur.com/CFM0Pcr.png',
        height: 60,
        fit: BoxFit.contain,
        semanticLabel: 'Logo Red de Herramientas',
      ),
      actions: [
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
                  left: 16,
                  top: 0,
                  bottom: 0,
                  right: 50,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isSearchExpanded ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !_isSearchExpanded,
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Buscar...',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 18, color: AppColors.textMain),
                          onSubmitted: _handleSearch,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    iconSize: 28,
                    icon: Icon(_isSearchExpanded ? Icons.close : Icons.search),
                    color: AppColors.dominant,
                    splashRadius: 24,
                    onPressed: () {
                      setState(() {
                        _isSearchExpanded = !_isSearchExpanded;
                        if (!_isSearchExpanded) {
                          _searchController.clear();
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Menú de tamaño de fuente
        PopupMenuButton<double>(
          icon: const Icon(Icons.format_size, color: AppColors.dominant),
          tooltip: 'Tamaño de fuente',
          onSelected: widget.onSetFontScale,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0.85, child: Text('Pequeña')),
            const PopupMenuItem(value: 1.0, child: Text('Normal')),
            const PopupMenuItem(value: 1.15, child: Text('Grande')),
            const PopupMenuItem(value: 1.3, child: Text('Muy Grande')),
          ],
        ),
        if (isDesktop) const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
            ),
            child: Center(
              child: Image.network(
                'https://i.imgur.com/CFM0Pcr.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          _drawerItem("Inicio", onTap: () {
            Navigator.pop(context);
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
          }),
          _drawerItem("Quiénes Somos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
          _drawerItem("Actividades", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_propuestasKey);
          }),
          _drawerItem("Recursos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_recursosKey);
          }),
          _drawerItem("Contacto", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
          _drawerItem("Donar", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_donateKey);
          }, isHighlighted: true),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, {VoidCallback? onTap, bool isHighlighted = false}) {
    return Container(
      color: isHighlighted ? AppColors.dominant.withOpacity(0.15) : Colors.transparent,
      child: ListTile(
        title: Text(
          title, 
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
            color: isHighlighted ? AppColors.dominant : AppColors.textMain
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EjesSection(key: _actividadesKey),
              _buildSeparator(isMobile: false),
              PropuestasSection(key: _propuestasKey),
              _buildSeparator(isMobile: false),
              RecursosSection(key: _recursosKey),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: SidebarSection(donateKey: _donateKey), // Donate & Novedades
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isSearchExpanded) 
           Container(key: _inicioKey),
        EjesSection(key: _actividadesKey),
        _buildSeparator(isMobile: true),
        PropuestasSection(key: _propuestasKey),
        _buildSeparator(isMobile: true),
        RecursosSection(key: _recursosKey),
        const SizedBox(height: 60),
        SidebarSection(donateKey: _donateKey),
      ],
    );
  }

  Widget _buildSeparator({required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 30 : 40),
      child: Container(
        height: 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFCC6E83),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A0514),
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: isDesktop ? 60 : 20),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://i.imgur.com/CFM0Pcr.png',
                height: 50,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Asociación Civil Sin Fines de Lucro - IGJ N° 1981600",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Propiciamos espacios que garanticen inclusión social, cultural y de los derechos de las mujeres adultas mayores.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isDesktop) const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(right: isDesktop ? 100.0 : 0.0),
            child: Row(
              mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, size: 40, color: Colors.blue),
                onPressed: () => launchUrl(Uri.parse('https://www.facebook.com/share/1RiPWewXqR/')),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 40, color: Colors.purple), 
                onPressed: () => launchUrl(Uri.parse('https://www.instagram.com/redherramientas?stkn=MW01cnN1eHlheHExMA==')),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 40, color: Colors.red),
                onPressed: () => launchUrl(Uri.parse('https://youtube.com/@reddeherramientasentremujeres?si=X0ZCFkMKebH4L3lk')),
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SECTIONS
// ==========================================

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage >= carouselNews.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showNewsDialog(BuildContext context, NewsArticle article) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    article.imageUrl,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(ctx).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            article.expandedText,
                            style: const TextStyle(fontSize: 18, color: AppColors.textMain, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.dominant, foregroundColor: Colors.white),
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text("CERRAR"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    double heroHeight = isDesktop ? 600 : 450;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: heroHeight,
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: carouselNews.length,
                itemBuilder: (context, index) {
                  final article = carouselNews[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Blurred background for un-cropped image aesthetic if proportions mismatch
                      Image.network(
                        article.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(color: Colors.black.withOpacity(0.4)),
                      // The uncropped image
                      Image.network(
                        article.imageUrl,
                        fit: BoxFit.contain, // sin recortar en altura
                      ),
                      // Text overlay
                      Positioned(
                        bottom: 40,
                        left: isDesktop ? 60 : 20,
                        right: isDesktop ? 60 : 20,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                article.shortDescription,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () => _showNewsDialog(context, article),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.dominant,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("VER MÁS"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              // Left Arrow
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
                    onPressed: () {
                      _timer?.cancel(); // pause on manual interaction
                      if (_currentPage > 0) {
                        _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      } else {
                        _pageController.animateToPage(carouselNews.length - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }
                    },
                  ),
                ),
              ),
              // Right Arrow
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 40),
                    onPressed: () {
                      _timer?.cancel();
                      if (_currentPage < carouselNews.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      } else {
                        _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }
                    },
                  ),
                ),
              ),
              // Dots indicator
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    carouselNews.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 12,
                      width: _currentPage == index ? 32 : 12,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppColors.dominant : Colors.white70,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NewsArticle {
  final String title;
  final String shortDescription;
  final String expandedText;
  final String imageUrl;

  NewsArticle({
    required this.title,
    required this.shortDescription,
    required this.expandedText,
    required this.imageUrl,
  });
}

final List<NewsArticle> carouselNews = [
  NewsArticle(
    title: '¿Qué es #ClicSeguroEnRED?',
    shortDescription: 'Un nuevo espacio para adultas mayores enfocado en la prevención de estafas digitales.',
    expandedText: 'Los facilitadores somos también mujeres mayores, lo que conlleva empatía necesaria para generar clima de seguridad. Hablamos de autonomía tecnológica que les permita dejar de pedir ayuda para las tareas cotidianas relacionadas con la tecnología, como pedir un turno médico o escanear una receta.',
    imageUrl: 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&q=80&w=800',
  ),
  NewsArticle(
    title: 'Talleres de Sensibilización',
    shortDescription: 'Iniciamos nuestro ciclo de talleres presenciales para el buen uso del celular.',
    expandedText: 'Realizamos el primer taller introductorio sobre seguridad en dispositivos móviles. Abordamos los temores comunes, cómo configurar contraseñas seguras y reconocer mensajes engañosos por WhatsApp o SMS.',
    imageUrl: 'https://images.unsplash.com/photo-1581056771107-24ca5f033842?auto=format&fit=crop&q=80&w=800',
  ),
];

class EjesSection extends StatelessWidget {
  const EjesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ejes de Trabajo",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26, color: AppColors.textMain),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = constraints.maxWidth > 800 ? 4 : (constraints.maxWidth > 500 ? 2 : 1);
            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2, 
              children: [
                _buildColoredEjeCard("Salud y Bienestar", Icons.health_and_safety, "Cuidado integral", Colors.red.shade50, Colors.red.shade800),
                _buildColoredEjeCard("Educación y Cultura", Icons.school, "Formación continua", Colors.blue.shade50, Colors.blue.shade800),
                _buildColoredEjeCard("Derechos", Icons.balance, "Defensa y promoción", Colors.purple.shade50, Colors.purple.shade800),
                _buildColoredEjeCard("Medio Ambiente", Icons.eco, "Sustentabilidad", Colors.green.shade50, Colors.green.shade800),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildColoredEjeCard(String title, IconData icon, String subtitle, Color bgColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Icon(icon, size: 40, color: iconColor),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: iconColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PropuestasSection extends StatelessWidget {
  const PropuestasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final propuestas = [
      {"icon": "🤝", "text": "Alianzas con centros de jubilados locales."},
      {"icon": "💻", "text": "Talleres de alfabetización digital y seguridad online."},
      {"icon": "🎭", "text": "Encuentros culturales y recreativos (teatro, literatura)."},
      {"icon": "🌱", "text": "Promoción de prácticas sustentables e huertas comunitarias."},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nuestras propuestas", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26, color: AppColors.textMain)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: propuestas.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Row(
                  children: [
                    Text(item["icon"]!, style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        item["text"]!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class RecursosSection extends StatelessWidget {
  const RecursosSection({super.key});

  @override
  Widget build(BuildContext context) {
    final resources = [
      "Cómo detectar estafas virtuales.",
      "Configuraciones de accesibilidad.",
      "Uso seguro de WhatsApp.",
      "Tutoriales paso a paso.",
      "Guías sobre inteligencia artificial."
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recursos destacados", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26, color: AppColors.textMain)),
        const SizedBox(height: 24),
        
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = constraints.maxWidth > 700 ? 5 : 2;
            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2 / 3,
              children: resources.map((res) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.dominant,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, size: 40, color: AppColors.mustardDonate),
                      const SizedBox(height: 24),
                      Text(
                        res,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class SidebarSection extends StatelessWidget {
  final GlobalKey? donateKey;
  const SidebarSection({super.key, this.donateKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          key: donateKey,
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Text("Apoyá nuestro espacio", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Container(
                width: 120,
                height: 120,
                color: Colors.black12,
                child: const Icon(Icons.qr_code, size: 80, color: Colors.black87),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.volunteer_activism, size: 28),
                label: const Text("DONAR"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mustardDonate,
                  foregroundColor: AppColors.textMain,
                  minimumSize: const Size(double.infinity, 80),
                  textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        Text("NOVEDADES", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26, color: AppColors.separatorBar)),
        const SizedBox(height: 24),
        _buildNovedadCard("Encuentro presencial: Uso del cajero automático", "15 de Octubre, 2026"),
        _buildNovedadCard("Taller Online: Protegiendo nuestras contraseñas", "22 de Octubre, 2026"),
        _buildNovedadCard("Charla Abierta: Derribando mitos sobre la IA", "05 de Noviembre, 2026"),
      ],
    );
  }

  Widget _buildNovedadCard(String title, String date) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: AppColors.dominant, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 16, color: AppColors.dominant, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
