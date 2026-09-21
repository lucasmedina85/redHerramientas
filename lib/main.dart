import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RedHerramientasApp());
}

// 🎨 1. Paleta de Colores
class AppColors {
  static const Color backgroundMain = Color(0xFFFAFAFA);
  static const Color textMain = Color(0xFF1A1A1A);
  static const Color dominant = Color(0xFFC77986); // Rosa pastel oscuro
  static const Color accent = Color(0xFFD95D39); // Terracota cálido
  static const Color backgroundSecondary = Color(0xFFE9ECEF);
  static const Color separatorBar = Color(0xFFFF007F);
  static const Color separatorText = Color(0xFFE9ECEF);
  static const Color mustardDonate = Color(0xFFFFDB58);
  
  static const Color btnBlue = Color(0xFF1A237E);
  static const Color btnGreen = Color(0xFF1B5E20);
  static const Color btnRed = Color(0xFFB71C1C);
  static const Color btnBlack = Color(0xFF212121);
}

class RedHerramientasApp extends StatelessWidget {
  const RedHerramientasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red de Herramientas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundMain,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.dominant,
          background: AppColors.backgroundMain,
        ),
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
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _donateKey = GlobalKey();
  
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: _buildAppBar(context),
      // 🍔 Menú Hamburguesa ("3 rayas") presente tanto en Desktop como en Mobile
      drawer: _buildDrawer(context),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'whatsapp',
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              // launchUrl(Uri.parse('https://wa.me/numerodetelefono'));
            },
            child: ClipOval(
              child: Image.asset(
                'assets/whatsapp.png',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
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
            // Barra superior (separador visual)
            Container(
              width: double.infinity,
              color: AppColors.separatorBar,
              height: 20,
            ),
            
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
            _buildFooter(isDesktop),
          ],
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
                    Text(
                      "Asociación Civil Sin Fines de Lucro - IGJ N° 1981600",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Propiciamos, desde el campo nacional y popular, espacios que garanticen inclusión social, cultural y de los derechos de las mujeres adultas mayores.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isDesktop) const SizedBox(height: 30),
          Row(
            mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.blueAccent),
                onPressed: () {},
                iconSize: 32,
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.redAccent),
                onPressed: () {},
                iconSize: 32,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.pinkAccent),
                onPressed: () {},
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 90,
      iconTheme: const IconThemeData(color: AppColors.dominant, size: 36), // Icono Hamburguesa grande
      title: Image.network(
        'https://i.imgur.com/CFM0Pcr.png',
        height: 60,
        fit: BoxFit.contain,
        semanticLabel: 'Logo Red de Herramientas',
      ),
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
                semanticLabel: 'Logo Red de Herramientas',
              ),
            ),
          ),
          _drawerItem("Inicio", onTap: () {
            Navigator.pop(context);
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          }),
          _drawerItem("Quiénes Somos"),
          _drawerItem("Nuestras Secciones"),
          
          // Submenú Desplegable de TEMAS
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: const Text("Temas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              iconColor: AppColors.accent,
              collapsedIconColor: AppColors.dominant,
              childrenPadding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
              children: [
                _drawerSubItem("Audiolibros"),
                _drawerSubItem("Biblioteca Virtual"),
                _drawerSubItem("Cultura"),
                _drawerSubItem("Derechos"),
                _drawerSubItem("Leyes y Proyectos de Ley"),
                _drawerSubItem("Revista Colaborativa"),
                _drawerSubItem("Soberanía Alimentaria"),
              ],
            ),
          ),
          
          _drawerItem("Contactanos"),
          _drawerItem("Donar", isHighlighted: true, onTap: () {
            final targetContext = _donateKey.currentContext;
            Navigator.pop(context); // Cierra el menú lateral
            
            if (targetContext != null) {
              Future.delayed(const Duration(milliseconds: 100), () {
                Scrollable.ensureVisible(
                  targetContext,
                  alignment: 0.5,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              });
            } else {
              // Fallback en caso de que el key falle: scrollear al máximo posible
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              );
            }
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
        onTap: onTap ?? () {},
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
    );
  }

  Widget _drawerSubItem(String title) {
    return ListTile(
      title: Text("• $title", style: const TextStyle(fontSize: 18, color: AppColors.dominant)),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              HeroSection(),
              SizedBox(height: 50),
              BannerRevista(), 
              SizedBox(height: 50),
              ActividadesSection(),
              SizedBox(height: 50),
              PropuestasSection(),
              SizedBox(height: 50),
              RecursosSection(),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: SidebarSection(donateKey: _donateKey), // Right sidebar content
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSection(),
        SizedBox(height: 40),
        BannerRevista(),
        SizedBox(height: 40),
        ActividadesSection(),
        SizedBox(height: 40),
        PropuestasSection(),
        SizedBox(height: 40),
        RecursosSection(),
        SizedBox(height: 60),
        SidebarSection(donateKey: _donateKey),
      ],
    );
  }
}

// ==========================================
// SECCIONES PRINCIPALES
// ==========================================

// Modelo de datos para las Noticias
class NewsArticle {
  final String imageUrl;
  final String caption;
  final String kicker;
  final String headline;
  final String summary;
  final String expandedText;
  final String buttonText;

  NewsArticle({
    required this.imageUrl,
    required this.caption,
    required this.kicker,
    required this.headline,
    required this.summary,
    required this.expandedText,
    required this.buttonText,
  });
}

// Lista global de noticias para el carrusel
final List<NewsArticle> carouselNews = [
  NewsArticle(
    imageUrl: 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&q=80&w=800',
    caption: 'Participantes del programa en un taller práctico.',
    kicker: 'INICIATIVA / #ClicSeguroEnRED',
    headline: 'Tecnología y seguridad digital facilitado por y para personas mayores',
    summary: 'Un espacio impulsado para reducir la brecha digital y la de usabilidad, para promover el uso seguro y autónomo de la tecnología entre personas mayores.',
    expandedText: 'Los facilitadores somos también mujeres mayores, lo que conlleva empatía necesaria para generar clima de seguridad. Hablamos de autonomía tecnológica que les permita dejar de pedir ayuda para las tareas cotidianas relacionadas con la tecnología, como pedir un turno médico o escanear una receta.',
    buttonText: 'IR A LA NOTA',
  ),
  NewsArticle(
    imageUrl: 'https://images.unsplash.com/photo-1581056771107-24ca5f033842?auto=format&fit=crop&q=80&w=800',
    caption: 'Encuentro anual sobre autonomía física y digital.',
    kicker: 'EVENTO / Comunidad',
    headline: 'Próxima jornada de alfabetización y autonomía tecnológica',
    summary: 'Únete a nuestra próxima charla donde abordaremos los desafíos comunes al usar aplicaciones bancarias y de salud en el día a día.',
    expandedText: 'Durante la jornada contaremos con la participación de expertas en seguridad informática que nos guiarán paso a paso en la configuración de privacidad de WhatsApp, prevención de estafas telefónicas y gestión de contraseñas seguras. Te esperamos.',
    buttonText: 'IR A LA NOTA',
  ),
  NewsArticle(
    imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&q=80&w=800',
    caption: 'Grupo de estudio sobre uso de herramientas cotidianas.',
    kicker: 'EDUCACIÓN / Talleres',
    headline: 'Abiertas las inscripciones para el nuevo taller de Redes Sociales',
    summary: 'Aprende a comunicarte, subir fotos y compartir momentos con tu familia de manera segura, privada y sin intermediarios.',
    expandedText: 'Este curso tiene una duración de 4 semanas. Nos enfocaremos en plataformas como Facebook e Instagram, prestando especial atención a cómo identificar perfiles falsos y cómo configurar la cuenta para que solo nuestros seres queridos puedan ver nuestra información personal.',
    buttonText: 'VER CRONOGRAMA',
  ),
];

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
      if (_expandedIndex != null) return; // No gira si hay una tarjeta abierta leyendo
      
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
    
    // Alturas flexibles para que quepa todo sin problemas visuales
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
        
        // Contenedor principal del Carrusel
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: _expandedIndex != null ? expandedHeight : baseHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _expandedIndex = null; // Cierra la nota al cambiar de tarjeta
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
        
        // Barra de desplazamiento (Indicadores / Puntos)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselNews.length, (index) {
            bool isActive = _currentPage == index;
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                height: 12,
                width: isActive ? 32 : 12, // El activo es gris oscuro y más largo
                decoration: BoxDecoration(
                  color: isActive ? Colors.grey.shade800 : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }),
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
          // Imagen superior estática con epígrafe
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Text(
                    article.caption,
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
          
          // Contenido protegido con scroll interno si fuera necesario
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.kicker,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.separatorBar, letterSpacing: 1),
                  ),
                  const SizedBox(height: 12),
                  
                  Text(
                    article.headline,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900, 
                      color: AppColors.dominant,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(
                    article.summary,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  
                  if (isExpanded) ...[
                    const SizedBox(height: 16),
                    Text(
                      article.expandedText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ],
                  
                  const SizedBox(height: 8),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: onExpandToggle,
                      icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 24),
                      label: Text(
                        isExpanded ? "Ver menos" : "Ver más", 
                        style: const TextStyle(fontSize: 18)
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: AppColors.dominant,
                      ),
                      child: Text(article.buttonText, style: const TextStyle(fontSize: 18, letterSpacing: 1.2)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerRevista extends StatelessWidget {
  const BannerRevista({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accent, Colors.deepOrange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Revista Colaborativa",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                "Nuevos artículos y reflexiones #EntreMujeres",
                style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.9)),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.accent,
              minimumSize: const Size(220, 60),
            ),
            child: const Text("LEER REVISTA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }
}

class ActividadesSection extends StatelessWidget {
  const ActividadesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            int columns = constraints.maxWidth > 700 ? 4 : 2;
            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.85, 
              children: [
                _buildActivityCard("Derechos", null, AppColors.dominant, Icons.gavel),
                _buildActivityCard("Medio\nAmbiente", null, const Color(0xFF81B29A), Icons.eco),
                _buildActivityCard("Educación y\nCultura", null, const Color(0xFFDFB850), Icons.school),
                _buildActivityCard("Salud y\nBienestar", null, const Color(0xFF7AB4CA), Icons.favorite),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActivityCard(String title, String? subtitle, Color bgColor, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(icon, size: 40, color: Colors.white.withOpacity(0.9)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class PropuestasSection extends StatelessWidget {
  const PropuestasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final propuestas = [
      {"icon": "📱", "text": "Talleres y capacitaciones"},
      {"icon": "🔒", "text": "Consejos de seguridad digital"},
      {"icon": "🤖", "text": "Inteligencia artificial para la vida cotidiana"},
      {"icon": "🎙️", "text": "Contenidos audiovisuales"},
      {"icon": "📚", "text": "Guías y materiales descargables"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nuestras propuestas", style: Theme.of(context).textTheme.titleLarge),
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
        Text("Recursos destacados", style: Theme.of(context).textTheme.titleLarge),
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
              childAspectRatio: 2 / 3, // adaptados a 2x3
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
        const SizedBox(height: 40),
        
        // Enlaces explícitos adaptativos
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _actionLinkButton("ENLACE A LIC TIPS"),
            _actionLinkButton("ENLACE A LAS GRABACIONES"),
            _actionLinkButton("ENLACE A DRIVE CON MATERIAL"),
          ],
        )
      ],
    );
  }

  Widget _actionLinkButton(String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.link, size: 24),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundSecondary,
        foregroundColor: AppColors.dominant,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        minimumSize: const Size(200, 70), 
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }
}

// ==========================================
// COLUMN LATERAL / WIDGET INFORMATIVO
// ==========================================

class SidebarSection extends StatelessWidget {
  final GlobalKey? donateKey;
  const SidebarSection({super.key, this.donateKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bloque QR achicado y Botón Donar
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
              // QR más chico (Requerimiento)
              Container(
                width: 120, // Achicado
                height: 120,
                color: Colors.black12,
                child: const Icon(Icons.qr_code, size: 80, color: Colors.black87),
              ),
              const SizedBox(height: 32),
              // Botón DONAR reemplazando a WhatsApp
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

        // Novedades
        Text("NOVEDADES", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 26, color: AppColors.separatorBar)),
        const SizedBox(height: 24),
        _buildNovedadCard("Encuentro presencial: Uso del cajero automático", "15 de Octubre, 2023"),
        _buildNovedadCard("Taller Online: Protegiendo nuestras contraseñas", "22 de Octubre, 2023"),
        _buildNovedadCard("Charla Abierta: Derribando mitos sobre la IA", "05 de Noviembre, 2023"),
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
