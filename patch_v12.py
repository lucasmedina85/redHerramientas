import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add padding to the right of the social icons row in the footer
old_row = """          Row(
            mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, size: 40, color: Colors.blue),"""

new_row = """          Padding(
            padding: EdgeInsets.only(right: isDesktop ? 100.0 : 0.0),
            child: Row(
              mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, size: 40, color: Colors.blue),"""

content = content.replace(old_row, new_row)

# The row ends with the YouTube button, we need to add a closing parenthesis for Padding
old_end = """              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 40, color: Colors.red),
                onPressed: () => launchUrl(Uri.parse('https://www.youtube.com/@reddeherramientas')),
              ),
            ],
          ),"""

new_end = """              IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 40, color: Colors.red),
                onPressed: () => launchUrl(Uri.parse('https://www.youtube.com/@reddeherramientas')),
              ),
            ],
          ),
          ),"""
content = content.replace(old_end, new_end)


# Increase vertical space between FABs
content = content.replace('const SizedBox(height: 16),', 'const SizedBox(height: 24),')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
