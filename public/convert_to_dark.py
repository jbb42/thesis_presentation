import os
import re
import glob

def batch_convert_svgs(folder_path=".", bg_color="#121212"):
    search_pattern = os.path.join(folder_path, "*.svg")
    svg_files = glob.glob(search_pattern)
    
    if not svg_files:
        print("No SVG files found in the directory.")
        return

    for file_path in svg_files:
        # Skip files that have already been converted
        if file_path.endswith("_dark.svg"):
            continue
            
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 1. Swap ALL variations of black to a temporary placeholder
        content = re.sub(r'(?i)#000000', 'TEMP_SWAP', content)
        content = re.sub(r'(?i)#000(["\';])', r'TEMP_SWAP\1', content)
        content = re.sub(r'(?i)="black"', '="TEMP_SWAP"', content)
        content = re.sub(r'(?i):\s*black([;"])', r': TEMP_SWAP\1', content)
        content = re.sub(r'(?i)rgb\(\s*0%?\s*,\s*0%?\s*,\s*0%?\s*\)', 'TEMP_SWAP', content)
        
        # 2. Swap ALL variations of white to your Slidev dark background
        content = re.sub(r'(?i)#ffffff', bg_color, content)
        content = re.sub(r'(?i)#fff(["\';])', f'{bg_color}\\1', content)
        content = re.sub(r'(?i)="white"', f'="{bg_color}"', content)
        content = re.sub(r'(?i):\s*white([;"])', f': {bg_color}\\1', content)
        content = re.sub(r'(?i)rgb\(\s*255\s*,\s*255\s*,\s*255\s*\)', bg_color, content)
        content = re.sub(r'(?i)rgb\(\s*100%\s*,\s*100%\s*,\s*100%\s*\)', bg_color, content)
        
        # 3. Swap the temporary placeholder to white
        content = content.replace('TEMP_SWAP', '#ffffff')

        # 4. Inject native SVG styles right before the closing tag to catch "naked" text paths
        # NOTE: Removed the path stroke rule so text isn't artificially bolded!
        native_style = """
<style>
  path:not([fill]), g:not([fill]), text:not([fill]) { fill: #ffffff !important; }
  line:not([stroke]) { stroke: #ffffff !important; }
</style>
</svg>"""
        # Replace the closing tag safely (case-insensitive)
        content = re.sub(r'(?i)</svg>', native_style, content)

        # Create the new filename (e.g., cnn.svg -> cnn_dark.svg)
        output_path = file_path.replace(".svg", "_dark.svg")
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(content)
            
        print(f"Successfully converted: {os.path.basename(output_path)}")

if __name__ == "__main__":
    print("Starting SVG dark mode batch conversion...")
    batch_convert_svgs()
    print("All done!")
