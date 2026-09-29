from PIL import Image

def get_dominant_color(image_path):
    img = Image.open(image_path)
    img = img.convert('RGB')
    width, height = img.size
    r, g, b = img.getpixel((width // 2, height // 2))
    print(f"Color: #{r:02x}{g:02x}{b:02x}")

get_dominant_color('/home/lucas/.gemini/antigravity/brain/4cad5538-0c40-46ad-8109-3a4ea6ad381b/.user_uploaded/media_1790723577776.png')
