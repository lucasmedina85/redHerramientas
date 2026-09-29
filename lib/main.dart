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
    _searchKeywords['somos'] = _quienesSomosKey;
    _searchKeywords['actividades'] = _actividadesKey;
    _searchKeywords['recursos'] = _recursosKey;
    _searchKeywords['contacto'] = _contactoKey;
    _searchKeywords['donar'] = _donateKey;
    _searchKeywords['ejes'] = _actividadesKey;
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Scroll so item is near top
      );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat, color: Colors.white, size: 28),
        onPressed: () => launchUrl(Uri.parse('https://wa.me/5491122766776')),
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
                    _navItem("Inicio", () => _scrollToKey(_inicioKey)),
                    _navItem("Quiénes somos", () => _scrollToKey(_quienesSomosKey)), // HeroSection stands as Quienes somos via Clic Seguro en RED
                    _navItem("Actividades", () => _scrollToKey(_actividadesKey)),
                    _navItem("Recursos", () => _scrollToKey(_recursosKey)),
                    _navItem("Contacto", () => _scrollToKey(_contactoKey)),
                  ],
                ),
              ),
            
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
            _scrollToKey(_inicioKey);
          }),
          _drawerItem("Quiénes Somos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_quienesSomosKey);
          }),
          _drawerItem("Actividades", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_actividadesKey);
          }),
          _drawerItem("Recursos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_recursosKey);
          }),
          _drawerItem("Contacto", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
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
              HeroSection(key: _quienesSomosKey), // Carousel (acts as Quienes somos)
              const SizedBox(height: 50),
              EjesSection(key: _actividadesKey),
              const SizedBox(height: 50),
              PropuestasSection(),
              const SizedBox(height: 50),
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
        if (!_isSearchExpanded) // If not mobile desktop nav, _inicioKey is here
           Container(key: _inicioKey),
        HeroSection(key: _quienesSomosKey),
        const SizedBox(height: 40),
        EjesSection(key: _actividadesKey),
        const SizedBox(height: 40),
        PropuestasSection(),
        const SizedBox(height: 40),
        RecursosSection(key: _recursosKey),
        const SizedBox(height: 60),
        SidebarSection(donateKey: _donateKey),
      ],
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
          Row(
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
  final PageController _pageController = PageController(viewportFraction: 0.95);
  int _currentPage = 0;
  int? _expandedIndex;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_expandedIndex != null) return; 
      
      int nextPage = _currentPage + 1;
      if (nextPage >= carouselNews.length) {
        nextPage = 0;
      }
      if (_pageController.hasClients) {
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

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;
    
    double baseHeight = isDesktop ? 680 : 720;
    double expandedHeight = isDesktop ? 880 : 950;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Últimas Noticias y Novedades",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.dominant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: _expandedIndex != null ? expandedHeight : baseHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _expandedIndex = null;
              });
            },
            itemCount: carouselNews.length,
            itemBuilder: (context, index) {
              bool isExpanded = _expandedIndex == index;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 16.0 : 4.0),
                child: NewsCard(
                  article: carouselNews[index],
                  isExpanded: isExpanded,
                  onExpandToggle: () {
                    setState(() {
                      if (_expandedIndex == index) {
                        _expandedIndex = null;
                      } else {
                        _expandedIndex = index;
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            carouselNews.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 12,
              width: _currentPage == index ? 32 : 12,
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.dominant : Colors.black26,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final bool isExpanded;
  final VoidCallback onExpandToggle;

  const NewsCard({
    super.key, 
    required this.article,
    required this.isExpanded,
    required this.onExpandToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                article.imageUrl,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    article.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.shortDescription,
                  style: const TextStyle(fontSize: 18, color: AppColors.textMain, height: 1.5),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onExpandToggle,
                    icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 28),
                    label: Text(
                      isExpanded ? "VER MENOS" : "VER MÁS", 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(foregroundColor: AppColors.dominant),
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.backgroundSecondary,
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.expandedText,
                        style: const TextStyle(fontSize: 18, color: AppColors.textMain, height: 1.6),
                      ),
                      // Notice: No "Ir a la publicación" button as requested!
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
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
    imageUrl: 'https://i.imgur.com/K1YvIcd.jpeg',
  ),
  NewsArticle(
    title: 'Talleres de Sensibilización',
    shortDescription: 'Iniciamos nuestro ciclo de talleres presenciales para el buen uso del celular.',
    expandedText: 'Realizamos el primer taller introductorio sobre seguridad en dispositivos móviles. Abordamos los temores comunes, cómo configurar contraseñas seguras y reconocer mensajes engañosos por WhatsApp o SMS.',
    imageUrl: 'https://i.imgur.com/L7Xm7rQ.jpeg',
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
                _buildEjeCard("Salud y Bienestar", "https://i.imgur.com/L7Xm7rQ.jpeg", "Cuidado integral"),
                _buildEjeCard("Educación y Cultura", "https://i.imgur.com/K1YvIcd.jpeg", "Formación continua"),
                _buildEjeCard("Derechos", "https://i.imgur.com/L7Xm7rQ.jpeg", "Defensa y promoción"),
                _buildEjeCard("Medio Ambiente", "https://i.imgur.com/K1YvIcd.jpeg", "Sustentabilidad"),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildEjeCard(String title, String imageUrl, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          )
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
                      const SizedBox(height: 16),
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
