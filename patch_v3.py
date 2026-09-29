import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. FIX FAB: WhatsApp image and scroll to top
fab_replacement = """      floatingActionButton: Column(
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
      ),"""

content = re.sub(
    r"floatingActionButton: FloatingActionButton\([\s\S]*?launchUrl\(Uri.parse\('https://wa\.me/5491122766776'\)\),\s*\),",
    fab_replacement,
    content
)

# 2. CAROUSEL PHOTOS
# find 'https://i.imgur.com/K1YvIcd.jpeg' and replace with 'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&q=80&w=800'
content = content.replace(
    "'https://i.imgur.com/K1YvIcd.jpeg'",
    "'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&q=80&w=800'"
)
content = content.replace(
    "'https://i.imgur.com/L7Xm7rQ.jpeg'",
    "'https://images.unsplash.com/photo-1581056771107-24ca5f033842?auto=format&fit=crop&q=80&w=800'"
)
# add third photo just in case
content = content.replace(
    "'https://i.imgur.com/dK3fF0e.jpeg'",
    "'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&q=80&w=800'"
)


# 3. FONT SCALER
font_scaler_old = """        PopupMenuButton<double>(
          icon: const Icon(Icons.text_increase, color: AppColors.dominant),
          onSelected: onSetFontScale,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0.8, child: Text('Pequeña (A-)')),
            const PopupMenuItem(value: 1.0, child: Text('Normal (A)')),
            const PopupMenuItem(value: 1.2, child: Text('Grande (A+)')),
            const PopupMenuItem(value: 1.4, child: Text('Muy Grande (A++)')),
          ],
        ),"""

font_scaler_new = """        PopupMenuButton<double>(
          icon: const Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.dominant)),
          onSelected: onSetFontScale,
          itemBuilder: (context) => [
            const PopupMenuItem(value: 1.2, child: Text('Aumentar (A+)')),
            const PopupMenuItem(value: 1.0, child: Text('Normal (A)')),
            const PopupMenuItem(value: 0.8, child: Text('Reducir (a-)')),
          ],
        ),"""

content = content.replace(font_scaler_old, font_scaler_new)

# 4. DRAWER DONAR BUTTON
drawer_contacto = """          _drawerItem("Contacto", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),"""

drawer_donar = """          _drawerItem("Contacto", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
          _drawerItem("Donar", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_donateKey);
          }, isHighlighted: true),"""

content = content.replace(drawer_contacto, drawer_donar)

# 5. FOOTER
footer_old = """  Widget _buildFooter(bool isDesktop) {
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
              const Text(
                "Red de Herramientas\npara Entornos Digitales",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          if (!isDesktop) const SizedBox(height: 30),
          Row(
            mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook, 'https://www.facebook.com/share/1RiPWewXqR/'),
              const SizedBox(width: 16),
              _socialIcon(Icons.camera_alt, 'https://www.instagram.com/redherramientas?stkn=MW01cnN1eHlheHExMA=='),
              const SizedBox(width: 16),
              _socialIcon(Icons.play_arrow, 'https://youtube.com/@reddeherramientasentremujeres?si=X0ZCFkMKebH4L3lk'),
            ],
          ),
        ],
      ),
    );
  }"""

footer_new = """  Widget _buildFooter(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0A0514),
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: isDesktop ? 60 : 20),
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://i.imgur.com/CFM0Pcr.png',
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            "Asociación Civil\nRed de Herramientas para Entornos Digitales",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook, 'https://www.facebook.com/share/1RiPWewXqR/'),
              const SizedBox(width: 16),
              _socialIcon(Icons.camera_alt, 'https://www.instagram.com/redherramientas?stkn=MW01cnN1eHlheHExMA=='),
              const SizedBox(width: 16),
              _socialIcon(Icons.play_arrow, 'https://youtube.com/@reddeherramientasentremujeres?si=X0ZCFkMKebH4L3lk'),
            ],
          ),
        ],
      ),
    );
  }"""

content = content.replace(footer_old, footer_new)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print("Patch V3 applied.")
