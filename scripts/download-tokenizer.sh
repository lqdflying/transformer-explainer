#!/bin/bash
set -e

MODEL_DIR="static/models/Xenova/gpt2"
mkdir -p "$MODEL_DIR"

echo "Downloading GPT-2 tokenizer files..."
curl -L -o "$MODEL_DIR/tokenizer.json" \
  https://huggingface.co/Xenova/gpt2/resolve/main/tokenizer.json
curl -L -o "$MODEL_DIR/tokenizer_config.json" \
  https://huggingface.co/Xenova/gpt2/resolve/main/tokenizer_config.json

echo "Done. Files saved to $MODEL_DIR"
