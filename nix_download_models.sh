#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash curl


echo "Downloading Models..."

urls=(
    "https://github.com/dnhkng/GlaDOS/releases/download/0.1/glados.onnx"
    "https://github.com/dnhkng/GlaDOS/releases/download/0.1/nemo-parakeet_tdt_ctc_110m.onnx"
    "https://github.com/dnhkng/GlaDOS/releases/download/0.1/phomenizer_en.onnx"
    "https://github.com/dnhkng/GlaDOS/releases/download/0.1/silero_vad.onnx"
)
files=(
    "models/glados.onnx"
    "models/nemo-parakeet_tdt_ctc_110m.onnx"
    "models/phomenizer_en.onnx"
    "models/silero_vad.onnx"
)

# Loop through arrays by index
for i in "${!urls[@]}"; do
    echo "Checking file: ${files[$i]}"
    if [ -f "${files[$i]}" ]; then
        echo "File ${files[$i]} already exists."
    else
        echo "File ${files[$i]} does not exist. Downloading..."
        mkdir -p "$(dirname "${files[$i]}")" # Create the directory if it doesn't exist
        curl -L "${urls[$i]}" --output "${files[$i]}"
        if [ -f "${files[$i]}" ]; then
            echo "Download successful."
        else
            echo "Download failed."
        fi
    fi
done

echo "Installation Complete!"