# Transformer Explainer

Interactive visualization of how Transformer-based models like GPT work. Runs a live GPT-2 model in your browser.

## Quick Start

```bash
docker run -d --name transformer-explainer -p 8080:80 lqdflying/transformer-explainer:latest
```

Open http://localhost:8080 in your browser.

## What's inside

- **Node 20 + SvelteKit** static build
- **GPT-2 ONNX model** (~600MB) — runs inference in-browser via ONNX Runtime Web
- **GPT-2 tokenizer** — bundled locally to avoid CORS issues with HuggingFace
- **nginx** — serves the static site with gzip compression and SPA fallback

## Features

- Type your own text prompt and click **Generate** to see next-token prediction
- Swap between 5 example prompts
- Adjust **temperature** and **sampling strategy** (top-k / top-p)
- Hover over vectors and attention maps to inspect values
- Step through transformer blocks with animations

## Ports

| Container | Host | Usage |
|-----------|------|-------|
| 80 | 8080 | Web UI |

Change host port if 8080 is busy:
```bash
docker run -d --name transformer-explainer -p 3000:80 lqdflying/transformer-explainer:latest
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `BASE_PATH` | `""` | Base URL path (set to `/your-path` if serving under a subpath) |

## Build from source

```bash
git clone https://github.com/lqdflying/transformer-explainer.git
cd transformer-explainer
docker build -t transformer-explainer .
docker run -d --name te -p 8080:80 transformer-explainer
```

## Stop / Remove

```bash
docker stop transformer-explainer
docker rm transformer-explainer
```

## Image Size

~1.3 GB (includes ONNX model weights)

## Source

https://github.com/lqdflying/transformer-explainer

## Original Project

https://poloclub.github.io/transformer-explainer
