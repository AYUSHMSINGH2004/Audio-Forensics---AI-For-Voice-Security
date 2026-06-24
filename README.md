# Audio Forensics: AI for Voice Security

A multi-stage audio deepfake detection platform built to identify synthetic voice attacks, support real-time security decisions, and provide a clean operator-facing threat report for both static uploads and live streaming analysis.

## What this project does

This system evolves from an early spectrogram-based CRNN into a production-grade voice security platform built around transformer embeddings, handcrafted forensic features, Siamese similarity learning, and dual-branch fusion.

It includes:

- a full data preprocessing and dataset generation pipeline
- multiple model generations from Version 1 through Version 8.1
- a FastAPI backend for static uploads and live WebSocket streaming
- a React/Vite frontend for analysis, history, and operator workflows
- deployment support for Docker and Cloud Run

## High-level pipeline

1. Raw multilingual speech is downloaded, extracted, cleaned, and normalized.
2. Real and fake samples are aligned, filtered, and converted into training-ready assets.
3. Features are generated using mel spectrograms, Wav2Vec2, WavLM, LFCC, and forensic statistics.
4. Model versions are trained iteratively, from CRNN-based classification to transformer embeddings and Siamese matching.
5. The latest backend exposes both static file analysis and live streaming inference.
6. The frontend converts results into clear threat tiers and action reports.

## Repository / project structure

- `Data Preprocessing/` — dataset download, extraction, validation, and audio normalization utilities
- `Frontend/` — operator UI, API client, WebSocket stream handling, authentication, history, and information pages
- `Backend/` — production model code for Versions 8 and 8.1, plus Cloud Run deployment assets
- `Untitled.ipynb` — notebook containing Versions 1 to 4, Version 5 inference adaptation, and exploratory testing
- `v6_train.py`, `step1_extract_dna.py`, `step2_train_head.py`, `v7_siamese_train.py`, `main.py` — standalone scripts for later model versions

## Data preprocessing and dataset engineering

The preprocessing stack is one of the most important parts of the project. It turns raw multilingual speech and synthetic speech into a stable forensic dataset.

### 1) Language-aware audio collection

The dataset builder uses multilingual Common Voice-style archives and language filtering so that real speech is matched with the correct language bucket. A GlotLID-based filter is used to keep only sentences that belong to the intended language.

### 2) Real audio extraction and normalization

The `extract_voices.sh` and `master_pipeline.py` scripts extract `clips/` and `validated_sentences.tsv` from compressed tar archives, flatten the folder structure, and prepare language-specific real audio folders.

### 3) Synthetic audio generation

The project uses several TTS engines to build a strong fake-audio corpus:

- OpenAI TTS / Voice generation
- Google Cloud TTS
- Coqui XTTSv2
- Microsoft Edge TTS
- gTTS and eSpeak fallbacks for unsupported languages

These engines are used to generate multiple fake variants per language and to test robustness against different synthesis styles.

### 4) Audio cleanup and standardization

The `convert_audio.py` pipeline normalizes mixed source formats into consistent WAV files using FFmpeg and Google Cloud Storage traversal.

Standardization typically includes:

- resampling to 16 kHz
- mono conversion
- silence trimming or VAD-style filtering
- chunking into fixed windows
- padding or truncation for consistent input length
- removal of corrupted or too-small files

### 5) Feature preparation

Depending on the version, the project generates:

- mel spectrograms for early CNN/CRNN models
- Wav2Vec2 embeddings for transformer-based classification
- WavLM embeddings for stronger speech representations
- LFCC descriptors for micro-spectral artifacts
- handcrafted statistics such as phase-jitter variance
- Siamese pairs for similarity learning

## Model version history

### Version 1 — CRNN foundation

**Core idea:** a spectrogram-based classifier built from a modified ResNet18 front-end and a bidirectional LSTM back-end.

**Input representation:** mel spectrograms generated offline from `.wav` files and saved as `.npy` matrices.

**Main techniques used:**

- mel-spectrogram generation
- spectrogram resizing / width normalization
- ResNet18 adapted for 1-channel audio images
- BiLSTM sequence modeling
- `torch.backends.cudnn.enabled = False` safety workaround for GPU stability

**Role in the project:** this version established the first end-to-end audio-forensics baseline and proved the data pipeline could support deep learning training.

---

### Version 2 — aggressive augmentation CRNN

**Core idea:** keep the CRNN backbone, but force the model to learn more robust artifacts by degrading the input every batch.

**Main techniques used:**

- batch-time noise injection
- SpecAugment-style time masking
- SpecAugment-style frequency masking
- stronger regularization against overfitting
- same CRNN backbone as Version 1

**Role in the project:** Version 2 reduced shortcut learning by making the training data intentionally harder and closer to real-world noisy speech.

---

### Version 3 — hybrid augmentation CRNN

**Core idea:** move from always-on augmentation to probabilistic augmentation.

**Main techniques used:**

- augmentation applied only part of the time instead of on every sample
- simulated analog-hole / room-like smearing
- reverberation-like spectrogram perturbations
- continued use of the CRNN backbone

**Why it mattered:** Version 3 improved generalization by mixing pristine studio-like synthetic speech with degraded call-like speech.

#### Version 3.1 and 3.2

The notebook also includes later Version 3 testing refinements:

- Whisper-based language detection
- whole-clip inference instead of only the first window
- improved evaluation metrics, confusion matrices, and KDE plots
- ONNX export and CPU-friendly inference testing

These steps mark the transition from a pure research model to a more production-aware inference flow.

---

### Version 4 — Wav2Vec2 + XGBoost production shift

**Core idea:** replace spectrogram image classification with deep speech embeddings.

**Feature pipeline:**

- raw waveform chunking at 2.5-second windows
- silence filtering using RMS energy thresholds
- Wav2Vec2 feature extraction
- mean pooling over hidden states to get a 768-dimensional embedding
- XGBoost meta-classifier on top of embeddings
- Whisper tiny for language detection

**Main techniques used:**

- transformer embeddings instead of image features
- chunk-level inference across the whole clip
- live threat-tier reporting
- Jupyter-based upload interface for operator testing

**Role in the project:** Version 4 is the major pivot away from image-based audio classification toward speech-embedding forensics.

#### Version 4.1 — safer and more resilient training

Version 4.1 keeps the Wav2Vec2 + XGBoost design but hardens the pipeline.

**New protections and upgrades:**

- `torchaudio` used for safer audio loading
- SIGALRM watchdog to kill corrupted-file deadlocks
- more robust training on large datasets
- improved stability for long extraction runs

**Why it mattered:** this version reduced the risk of training jobs freezing silently on bad audio files.

---

### Version 5 — production inference wrapper

Version 5 does not introduce a standalone training script. Instead, it wraps the Version 4 pipeline into a production API.

**What changed from Version 4:**

- Wav2Vec2 inference is moved to ONNXRuntime
- FastAPI backend is added
- static analysis endpoint is exposed
- live WebSocket streaming endpoint is exposed
- Whisper tiny is used for language detection
- XGBoost remains the decision layer
- threat reports are returned as operator-ready action lists

**API behavior:**

- `POST /analyze` for static uploads
- `WS /ws/stream` for live chunk streaming
- `GET /` for health/status

**Role in the project:** Version 5 is the first production-style security engine with a real backend and streaming support.

---

### Version 6 — forensic math + Wav2Vec2 + XGBoost

Version 6 adds handcrafted forensic features on top of transformer embeddings.

**Feature engineering:**

- Wav2Vec2 acoustic embeddings
- LFCC-style statistical features from the log-spectrogram
- phase-difference analysis
- phase-jitter variance
- concatenated acoustic + forensic vectors

**Preprocessing and augmentation:**

- audio resampling to 16 kHz
- mono conversion
- optional noise injection
- amplitude scaling
- VoIP-style bandpass filtering
- data sources combined from `local_data`, `local_data_v6_fakes`, and `synthetic_booster_pack`

**Training details:**

- features checkpointed to `.npy` files
- XGBoost trained with conservative regularization
- evaluation plotted with confusion matrix and KDE distributions

**Role in the project:** Version 6 increased robustness by combining learned embeddings with handcrafted signal-analysis features.

#### Version 6 testing upgrade

The later testing notebook adds:

- silence removal before inference
- Whisper base language detection
- stricter threat thresholds
- cleaner operator output

---

### Version 7 — Siamese WavLM similarity model

Version 7 moves from single-clip classification to pairwise similarity learning.

**Core idea:** compare two audio clips and learn whether they are naturally similar or suspiciously synthetic.

**Main techniques used:**

- WavLM base-plus as the shared encoder
- Siamese architecture with shared weights
- absolute difference between embeddings
- binary cross-entropy with logits
- dynamic positive/negative pair construction
- gradient accumulation to fit on limited VRAM
- fixed 16 kHz, 4-second standardized inputs
- headless evaluation plots saved to disk

**Pairing strategy:**

- negative pairs: real audio matched against its exact synthetic counterpart
- positive pairs: real audio matched against a different real voice sample

**Role in the project:** Version 7 reframes deepfake detection as a similarity problem, which is especially useful when the synthetic clip is a close clone of the original.

---

### Version 8 — full-clip WavLM DNA classifier

Version 8 simplifies the pipeline into a pure WavLM embedding approach.

**Feature pipeline:**

- whole-clip sliding window extraction
- 4-second chunks with 2-second overlap
- WavLM embeddings averaged into a master clip vector
- separate caches for real and fake vectors
- XGBoost classifier on the WavLM DNA vectors

**Role in the project:** Version 8 is a streamlined, production-oriented transformer baseline.

**Reported evaluation from the provided metrics file:**

- Accuracy: **99.71%**

---

### Version 8.1 — dual-branch WavLM + LFCC fusion

Version 8.1 is the latest production version and the strongest design in the provided code.

**Feature pipeline:**

- random telephonic augmentation on part of the data
- LFCC branch for micro-spectral artifacts
- WavLM branch for paralinguistic / speech-semantic structure
- concatenation into an 848-dimensional super-vector
- LightGBM meta-classifier

**Important implementation details:**

- LFCCs use 40 coefficients
- mean and standard deviation are computed per coefficient
- WavLM uses whole-clip sliding-window embeddings
- outputs are cached separately for real and fake classes
- Cloud Run deployment bundle is included

**Reported evaluation from the provided metrics file:**

- Accuracy: **99.84%**

## Latest backend architecture

The production backend for the latest release lives in `Backend/V_8_1_Production/V_8_1_Cloud_Run_Deployment/`.

### Static analysis endpoint

`POST /analyze`

Accepted audio types include:

- `.wav`
- `.mp3`
- `.ogg`
- `.flac`
- `.mp4` for the V8.1 deployment bundle

The endpoint returns:

- filename
- latency in milliseconds
- detected language
- threat level
- synthetic vs authentic probabilities
- an action report with operational guidance

### Live streaming endpoint

`WS /ws/stream`

The WebSocket flow supports:

- incremental chunk updates during the call
- cumulative end-of-stream summary
- threat-tier escalation
- action guidance for the operator

### Health endpoint

`GET /`

Returns a simple online status response.

## Frontend stack

The frontend is a React + Vite application that uses:

- React 18
- Vite
- Tailwind CSS
- shadcn/ui
- Framer Motion
- Lucide icons
- WaveSurfer.js
- WebSocket support for live analysis
- analysis history and auth-related UI

Key routes include:

- `/` — platform overview
- `/predict` — threat analysis engine
- `/how-it-works` — technical architecture
- `/dataset-intelligence` — multilingual dataset intelligence
- `/legal-recourse` — legal / escalation resource page
- `/analysis-history` — saved analysis history

## Backend link configuration

Set these environment variables in the frontend before running it:

```bash
VITE_API_BASE_URL=https://YOUR_BACKEND_DOMAIN
VITE_WS_BASE_URL=wss://YOUR_BACKEND_DOMAIN
```

If your backend is deployed at Cloud Run or another HTTPS host, use the same host for both variables. The WebSocket helper automatically converts `https://` to `wss://` when needed.

## Local development

### Backend

For the latest production backend:

```bash
cd Backend/V_8_1_Production/V_8_1_Cloud_Run_Deployment
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8080
```

### Frontend

```bash
cd Frontend
npm install
npm run dev
```

Before starting the frontend, fill in the backend URL values in `apps/web/.env.local`.

## Deployment

### Docker / Cloud Run

The V8.1 deployment bundle already includes a Dockerfile that:

- uses the official PyTorch CUDA runtime image
- installs FFmpeg and libsndfile
- installs Python requirements
- pre-bakes WavLM and Whisper assets into the image
- exposes port `8080`
- starts the FastAPI app with Uvicorn

A typical Cloud Run flow looks like this:

```bash
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/audio-forensics-backend

gcloud run deploy audio-forensics-backend \
  --image gcr.io/YOUR_PROJECT_ID/audio-forensics-backend \
  --platform managed \
  --region YOUR_REGION \
  --allow-unauthenticated
```

After deployment, copy the service URL into the frontend environment variables.

### Frontend deployment

Build the frontend with:

```bash
cd Frontend
npm run build
```

Then host the generated web build on your preferred static platform and point it to the deployed backend URL.

## Model files and outputs

Common outputs across versions include:

- `*.npy` spectrogram matrices
- `wavlm_dna_cache/` embedding caches
- `v6_features.npy` / `v6_labels.npy`
- `thunderbuddies_v4.json`
- `wav2vec2_onnx_production/model.onnx`
- `wavlm_siamese_v7.pth`
- `wavlm_siamese_head_only.pth`
- `v8_production/v8_xgboost_wavlm.json`
- `v8_1_production/v8_1_lightgbm.txt`

## Contributors

Replace the placeholders below with the actual team names and GitHub handles.

- **[Your Name]** — project lead, model iteration, backend integration
- **[Teammate Name]** — preprocessing, data generation, evaluation
- **[Teammate Name]** — frontend, dashboard, deployment
- **[Mentor / Advisor]** — review and guidance

## Notes

- The project contains both research notebooks and production-style code.
- Version 5 is an inference wrapper around Version 4, not a standalone training rewrite.
- Version 8.1 is the latest production-oriented backend in the provided files.
- If you are publishing this repository, make sure all private API keys, bucket names, and internal URLs are removed before pushing to GitHub.
