import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

new_card = """
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
"""

content = re.sub(r'  Widget _buildColoredEjeCard\(String title, IconData icon, String subtitle, Color bgColor, Color iconColor\) \{.*?\n  \}', new_card.strip('\n'), content, flags=re.DOTALL)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
