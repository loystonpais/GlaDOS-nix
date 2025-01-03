{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python312
    (python312.withPackages
      (ps:
        with ps; [
          onnxruntime
          # numpy
          sounddevice
          levenshtein
          loguru
          jinja2
          requests
          textual
          pyyaml
          librosa
        ]))
    curl
  ];

  shellHook = ''
    chmod +x nix_download_models.sh
    bash nix_download_models.sh

    if ! command -v ollama 2>&1 >/dev/null; then
      echo "Ollama is not installed."
      echo "Install with the help of https://wiki.nixos.org/wiki/Ollama"
      exit 1
    fi

    echo "Shell setup successful."
    echo "Run glados by doing python ./glados.py"
  '';

  LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
}
