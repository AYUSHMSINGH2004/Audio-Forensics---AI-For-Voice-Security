<div align="center">

# 🎙️ Audio Forensics
### AI for Voice Security

**A production-grade AI system for detecting synthetic speech, voice cloning, and AI-generated voice attacks — in real time.**

![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![Accuracy](https://img.shields.io/badge/Accuracy-99.84%25-success)
![Languages](https://img.shields.io/badge/Languages-9-orange)
![Python](https://img.shields.io/badge/Python-3.10+-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-Backend-009688)
![React](https://img.shields.io/badge/React-Frontend-61DAFB)
![PyTorch](https://img.shields.io/badge/PyTorch-WavLM-EE4C2C)
![GitHub stars](https://img.shields.io/github/stars/AYUSHMSINGH2004/Audio-Forensics---AI-For-Voice-Security?style=social)

</div>

---

## 📖 Overview

**Audio Forensics** is an AI-powered voice security platform built to detect synthetic speech, AI-generated voices, and voice cloning attacks.

The system evolved through **8+ model generations** — moving from spectrogram-based deep learning to a production forensic engine that fuses:

- 🧬 Transformer speech representations
- 🔬 Signal-processing forensic features
- 🧩 Siamese similarity learning
- 🌲 Ensemble machine learning
- ⚡ Real-time WebSocket inference

### Key Capabilities

| Capability | Description |
|---|---|
| ✅ Static Forensic Analysis | Deep analysis of uploaded audio recordings |
| ✅ Real-Time Interception | Live voice stream monitoring via WebSocket |
| ✅ AI Speech Detection | Identifies AI-generated and cloned voices |
| ✅ Threat Scoring | Quantified risk assessment per analysis |
| ✅ Automated Forensic Reports | Structured, actionable security output |

---

## 📑 Table of Contents

- [Live Deployments](#-live-deployments)
- [System Architecture](#-system-architecture)
- [Model Evolution](#-model-evolution)
- [Dataset & Model Download](#-dataset--model-download)
- [Dataset Intelligence](#-dataset-intelligence)
- [Language Identification (GlotLID)](#-language-identification-glotlid)
- [Synthetic Voice Generation Pipeline](#-synthetic-voice-generation-pipeline)
- [Audio Preprocessing](#-audio-preprocessing)
- [Feature Extraction](#-feature-extraction)
- [Data Augmentation](#-data-augmentation)
- [Testing & API Usage](#-testing--api-usage)
- [Frontend](#-frontend)
- [Threat Intelligence Report](#-threat-intelligence-report)
- [Performance](#-performance)
- [Technology Stack](#-technology-stack)
- [Security Practices](#-security-practices)
- [Notes](#-notes)
- [Contributors](#-contributors)
- [License](#-license)
- [Links](#-links)

---

## 🚀 Live Deployments

### Google Cloud Run — *Primary Production Deployment (archived)*

```
https://threat-engine-v8-810126162948.us-central1.run.app/
```

**Stack:** Docker · FastAPI · PyTorch · WavLM · Whisper · LightGBM · Google Cloud Container Registry

> Cloud Run was used because the full infrastructure lived inside Google Cloud. After validation, the service was stopped to avoid continuous billing.

### Hugging Face Spaces — *Current Public Backend*

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```

Provides: Static analysis API · WebSocket live streaming · V8.1 forensic inference

---

## 🧠 System Architecture

```mermaid
flowchart LR
    A[User Audio Input] --> B[REST API / WebSocket]
    B --> C[Audio Validation]
    C --> D[GlotLID Language Check]
    D --> E[Preprocessing]
    E --> F[WavLM Encoder]
    E --> G[LFCC Extraction]
    F --> H[Feature Fusion]
    G --> H
    H --> I[848-D Feature Vector]
    I --> J[LightGBM Classifier]
    J --> K[AI / Human Classification]
    K --> L[Threat Scoring]
    L --> M[Automated Forensic Report]
    M --> N[Dashboard]
```

**Pipeline at a glance:** `Audio Input → REST/WebSocket → Validation → Preprocessing → WavLM + LFCC → Feature Fusion → LightGBM → Threat Report`

---

## 🧬 Model Evolution

```mermaid
timeline
    title Audio Forensics Model Evolution
    V1 : CRNN + Mel Spectrogram : Baseline spectrogram deep learning
    V2 : Augmented CRNN : Noise injection, time/frequency masking
    V3 : Hybrid CRNN : Improved robustness
    V4 : Wav2Vec2 + XGBoost : Transformer embeddings, Whisper support
    V5 : Production Wrapper : FastAPI, ONNX inference, WebSocket streaming
    V6 : Wav2Vec2 + LFCC + XGBoost : Signal forensic features
    V7 : Siamese WavLM : Similarity learning, embedding comparison
    V8 : WavLM DNA + XGBoost : Cached embeddings, optimized inference
    V8.1 : WavLM + LFCC + LightGBM : Final production forensic engine
```

<details>
<summary><b>Expand version-by-version details</b></summary>

| Version | Architecture | Highlights |
|---|---|---|
| **V1** | CRNN + Mel Spectrogram | Baseline; limited generalization, noise-sensitive |
| **V2** | Augmented CRNN | Added noise injection, time/frequency masking |
| **V3** | Hybrid CRNN | Improved augmentation strategy and generalization |
| **V4** | Wav2Vec2 + XGBoost | Major shift to transformer embeddings + Whisper |
| **V5** | Production Wrapper | FastAPI, ONNX inference, static + WebSocket API |
| **V6** | Wav2Vec2 + LFCC + XGBoost | Added phase analysis, better artifact detection |
| **V7** | Siamese WavLM | WavLM encoder, pair-based similarity training |
| **V8** | WavLM DNA + XGBoost | Clip-level cached embeddings, efficient inference |
| **V8.1** | WavLM + LFCC + LightGBM | **Final production engine — 99.84% accuracy** |

</details>

### 🪜 Step-by-Step Model Evolution

#### V1 — CRNN + Mel Spectrogram
Initial baseline using spectrogram-based deep learning.
- **Limitations:** Limited generalization · sensitive to noise

#### V2 — Augmented CRNN
Improved on V1 by introducing data augmentation to the training pipeline.
- **Added:** Noise injection · Time masking · Frequency masking
- **Result:** Improved robustness over the V1 baseline

#### V3 — Hybrid CRNN
Refined the augmentation strategy further.
- **Result:** Improved generalization and a more stable hybrid CRNN design

#### V4 — Wav2Vec2 + XGBoost
A major architectural shift away from spectrograms and into transformer-based speech embeddings.
- **Added:** Wav2Vec2 transformer features · Whisper language support · XGBoost classifier
- **Result:** Significant jump in detection quality by moving to learned speech representations

#### V5 — Production Wrapper
Converted the V4 research model into deployable, production-ready infrastructure (a wrapper around V4, not a new model).
- **Added:** FastAPI service layer · ONNX inference · Static analysis API · WebSocket streaming
- **Result:** First version capable of being deployed and queried as a real service

#### V6 — Wav2Vec2 + LFCC + XGBoost
Introduced signal-processing forensic features alongside the transformer embeddings.
- **Added:** LFCC (Linear Frequency Cepstral Coefficients) features · Phase analysis
- **Result:** Better artifact detection by combining learned and hand-engineered forensic signals

#### V7 — Siamese WavLM
Introduced similarity-learning to compare voice samples directly.
- **Added:** WavLM encoder (replacing Wav2Vec2) · Pair-based Siamese training · Embedding comparison
- **Result:** Enabled the system to learn relative similarity between genuine and synthetic voices, not just absolute classification

#### V8 — WavLM DNA + XGBoost
A production-optimization pass focused on inference efficiency.
- **Added:** Clip-level WavLM embeddings · Embedding caching · More efficient inference pipeline
- **Result:** Faster, more scalable inference without sacrificing the V7 detection gains

#### V8.1 — WavLM + LFCC + LightGBM *(Final Production Engine)*
The final, fused architecture combining transformer embeddings with forensic signal features under a lighter, faster classifier.
- **Pipeline:** Audio → WavLM Encoder + LFCC Extraction → 848-D Feature Vector → LightGBM → AI / Human Classification
- **Added:** LightGBM meta-classifier (replacing XGBoost) for faster inference · Optimized LFCC feature extraction
- **Result:** **99.84% accuracy** — the current production forensic engine powering both the static and real-time APIs

---

## 📊 Dataset & Model Download

The complete Audio Forensics package (**27.4GB**) contains all major development assets from the project, including:

- 🧠 8 iterative model generations (V1 → V8.1)
- 🎙️ Raw real and synthetic audio datasets
- 🧪 Training and evaluation scripts
- 📓 Primary research and experimentation notebooks

The complete archive is available here:

- 🌐 [Internet Archive Project Page](https://archive.org/details/Audio-Forensics-Models)
- 💾 [Direct Download Directory](https://archive.org/download/Audio-Forensics-Models)

> The dataset package contains research artifacts, model evolution history, and supporting resources used throughout the development of the production forensic engine.

---

## 📊 Dataset Intelligence

The model is trained on a deliberately diverse mix of:

- Real human speech
- AI-generated synthetic speech
- Multilingual speech across multiple speakers
- Multiple TTS architectures

**Goal:** detect *synthetic artifacts* rather than memorizing language, speaker, or dataset bias.

### 🌍 Mozilla Data Collective

Built on **Mozilla's Open Voice Data Initiative**, a community-driven effort to democratize voice AI training data and increase representation of underrepresented languages (Kinyarwanda, Pashto, Bengali, and more).

### ⚖️ Real vs. Synthetic Split

| Type | Count | Share | Source |
|---|---|---|---|
| **Real Audio** | 45,000 | 50% | Mozilla Data Collective speech recordings |
| **Synthetic Audio** | 45,000 | 50% | MMS · x-TTS · Microsoft Edge TTS |

### 🌍 Language Selection History

The project initially started with support for **11 target languages**:

English, German, French, Spanish, Chinese, Catalan, Bengali, Kinyarwanda, Pashto, Belarusian, and Esperanto.

During dataset validation and preparation, Belarusian and Esperanto were removed due to:

- Limited available high-quality speech data
- Data scarcity for synthetic voice generation
- Language standardization and consistency challenges

The final production dataset and evaluation pipeline used **9 languages**:

English, German, French, Spanish, Chinese, Catalan, Bengali, Kinyarwanda, and Pashto.

### 🗣️ Language Coverage

<details>
<summary><b>Expand full language-by-language breakdown</b></summary>

| Language | ISO 639-3 | Synthetic Engine | Mozilla Dataset Source |
|---|---|---|---|
| English | `eng` | x-TTS | Common Voice Scripted Speech 26.0 - English |
| French | `fra` | x-TTS | Common Voice Scripted Speech 26.0 - French |
| German | `deu` | x-TTS | Common Voice Scripted Speech 26.0 - German |
| Spanish | `spa` | x-TTS | Common Voice Scripted Speech 26.0 - Spanish |
| Catalan | `cat` | MMS | Common Voice Scripted Speech 26.0 - Catalan |
| Bengali | `ben` | MMS | Common Voice Scripted Speech 26.0 - Bengali |
| Kinyarwanda | `kin` | MMS | Common Voice Scripted Speech 26.0 - Kinyarwanda |
| Pashto | `pus/pbt/pbu` | Microsoft Edge-TTS (Azure Neural fallback) | Common Voice Scripted Speech 26.0 - Pashto |
| Chinese | `zho/cmn` | Microsoft Edge-TTS (Azure Neural fallback) | Common Voice Scripted Speech 26.0 - Chinese (China) |

</details>

---

## 🔎 Language Identification (GlotLID)

GlotLID validates language identity **before training**, preventing incorrect labels, mixed-language samples, metadata errors, and misclassified recordings.

```text
Raw Audio Dataset
      ↓
Audio Extraction
      ↓
GlotLID Language Detection
      ↓
Confidence Filtering
      ↓
Valid Language Bucket
```

| Accepted ✅ | Rejected ❌ |
|---|---|
| Matching language | Wrong language |
| Valid confidence | Low confidence |
| Correct metadata | Corrupted samples |

---

## 🤖 Synthetic Voice Generation Pipeline

Synthetic speech sources used across the project: OpenAI TTS · Google Cloud TTS · Coqui XTTSv2 · Microsoft Edge TTS · MMS — used for voice cloning simulation, AI voice diversity, and robustness testing.

### 🎙️ ElevenLabs v3 Pipeline

A dedicated pipeline expanded the AI-generated speech dataset using the **ElevenLabs `eleven_v3`** model.

| Detail | Value |
|---|---|
| Clips generated | 7,700 synthetic clips |
| Target per language | 1,100 clips |
| Languages | English, German, French, Spanish, Chinese, Catalan, Bengali |
| Excluded at this stage | Kinyarwanda, Pashto |
| Voice diversity | 21 naturally sounding voices, dynamically fetched from the ElevenLabs voice library, randomly sampled per clip |

**Source transcription models** (real audio → text before synthesis):

| Languages | Transcription Model |
|---|---|
| English, German, French, Spanish, Chinese, Catalan | AssemblyAI Universal-3-Pro / Universal-2 |
| Bengali | OpenAI Whisper Small |

**Generation workflow:**

```text
Real Audio → Speech Transcription → Sentence Extraction
   → Random ElevenLabs Voice Selection → ElevenLabs eleven_v3 Generation
   → Synthetic Audio Output → Dataset Integration
```

### ☁️ OpenAI & Google Cloud TTS Booster Pack

A focused **130-clip booster pack** stress-tests the meta-classifier against unseen, state-of-the-art TTS engines beyond the main training pipeline — improving generalization and reducing dependency on training-source artifacts.

| Engine | Clips Generated |
|---|---|
| Google Cloud TTS | 70 |
| OpenAI TTS | 60 |
| **Total** | **130** |

Each language used **20 validated authentic sentences** as the seed set, with the following vendor routing strategy:

| Sentence Range | Engine |
|---|---|
| First 10 sentences | Google Cloud TTS (Neural2 / WaveNet) |
| Next 10 sentences | OpenAI TTS — `tts-1-hd`, Nova voice |


### 🗣️ Voice / Model Reference Table

| Language | Google Cloud Voice | OpenAI Voice |
|---|---|---|
| English | Journey — `en-US-Journey-D` | Nova (`tts-1-hd`) |
| French | Neural2 — `fr-FR-Neural2-A` | Nova (`tts-1-hd`) |
| Spanish | Neural2 — `es-ES-Neural2-A` | Nova (`tts-1-hd`) |
| German | Neural2 — `de-DE-Neural2-B` | Nova (`tts-1-hd`) |
| Chinese (Mandarin) | WaveNet — `cmn-CN-Wavenet-A` | Nova (`tts-1-hd`) |
| Catalan | Standard — `ca-ES-Standard-A` | Nova (`tts-1-hd`) |
| Bengali | WaveNet — `bn-IN-Wavenet-A` | — (not supported) |

</details>

---

## 🔊 Audio Preprocessing

```text
Input Audio → Format Validation → FFmpeg Conversion → 16kHz Resampling
   → Mono Conversion → Noise Filtering → Silence Removal
   → RMS Filtering → Chunk Generation → Feature Extraction
```

**Standard format:** 16,000 Hz · Mono · WAV
**Techniques:** FFmpeg validation · RMS energy filtering · silence trimming · language verification

### 🌧️ Environmental Noise Augmentation

To prevent the detector from learning *"clean audio = synthetic"* as a shortcut, every generated clip receives randomized low-level white noise injection and real-world recording/environmental simulation — improving robustness for phone recordings, voice calls, microphone variation, and real deployment conditions.

---

## 🧪 Testing & API Usage

### Static Analysis

**Endpoint:** `/analyze`

```python
import requests

url = "https://venkatasriram-audio-forensics-v8-1-demo.hf.space/analyze"

files = {
    "file": open("sample.wav", "rb")
}

response = requests.post(url, files=files)
print(response.json())
```

**Returns:** threat status · AI probability · human probability · language detection · action report

### 🎧 Live Streaming Testing

**File:** `live_stream_tester_v8_1.py`

```bash
pip install websockets librosa numpy nest_asyncio
```

```python
uri = "wss://venkatasriram-audio-forensics-v8-1-demo.hf.space/ws/stream"
TEST_FILE = "sample.wav"
```

```bash
python live_stream_tester_v8_1.py
```

**Process:** Load audio → Convert to 16kHz mono → Split into 4s chunks → Stream via WebSocket → Receive live predictions → Generate forensic report

---

## 🖥️ Frontend

**Built with:** React · Vite · Tailwind CSS · shadcn/ui · WebSockets · Firebase

**Features:** Authentication · Analysis history · Dashboard · Threat visualization · Real-time inference display

```text
React UI → WebSocket Client → FastAPI Backend → V8.1 Forensic Engine → Threat Report
```

| Component | Status |
|---|---|
| Backend | ✅ Deployed |
| AI Engine | ✅ Available |
| Frontend | ❌ Private / local only |

> The frontend repository is kept private because Firebase stores user records, authentication data, and analysis history.

---

## 🛡️ Threat Intelligence Report

Each analysis generates a structured forensic report:

```json
{
  "threat_status": "AI Generated | Human",
  "ai_probability": "...",
  "human_probability": "...",
  "detected_language": "...",
  "confidence_score": "...",
  "recommended_action": "..."
}
```

---

## 📈 Performance

| Metric | Value |
|---|---|
| Model | V8.1 |
| Architecture | WavLM + LFCC + LightGBM |
| Feature Size | 848 dimensions |
| **Accuracy** | **99.84%** |

---

## 📦 Technology Stack

| Category | Technologies |
|---|---|
| **AI / ML** | PyTorch, WavLM, Wav2Vec2, Whisper, LFCC, LightGBM, XGBoost, Siamese Networks |
| **Backend** | FastAPI, WebSockets, ONNX Runtime, Docker |
| **Deployment** | Google Cloud Run, Hugging Face Spaces, Google Cloud Container Registry |
| **Frontend** | React, Vite, Tailwind CSS, shadcn/ui, Firebase |

---

## 🔐 Security Practices

- ✅ Do not upload datasets publicly
- ✅ Do not commit Firebase credentials
- ✅ Do not commit model weights without Git LFS
- ✅ Keep API keys private
- ✅ Store production secrets using environment variables

---

## ⚠️ Notes

- Version 5 is a production wrapper around Version 4.
- Version 8.1 is the final production forensic engine.
- Synthetic datasets are generated only for research and robustness evaluation.
- Public deployment does not expose private datasets or model weights.

---

## 👥 Contributors

<div align="center">

### 🤝 Built by a Two-Person Team

![Collaboration](https://img.shields.io/badge/Collaboration-Equal%20Partnership-blueviolet)
![Contributors](https://img.shields.io/badge/Contributors-2-informational)

</div>

<table>
<tr>
<td width="50%" valign="top">

### 🧑‍💻 Ayush M Singh
**Co-Creator · AI & Backend Engineer**

[![GitHub](https://img.shields.io/badge/GitHub-AYUSHMSINGH2004-181717?logo=github&logoColor=white)](https://github.com/AYUSHMSINGH2004)

**Contributions:**
- 🧠 Model development across all V1 → V8.1 generations
- ⚙️ Backend engineering (FastAPI services, API design)
- 🔬 AI pipeline design — preprocessing, feature fusion, inference flow
- 📂 Dataset processing & curation (real + synthetic corpora)
- 🚀 System optimization & performance tuning

</td>
<td width="50%" valign="top">

### 🧑‍💻 Venkata Sriram Topalli
**Co-Creator · AI & Deployment Engineer**

**Contributions:**
- 🧠 Model development across all V1 → V8.1 generations
- ⚙️ Backend engineering (FastAPI services, API design)
- 🔬 AI pipeline design — preprocessing, feature fusion, inference flow
- 📂 Dataset processing & curation (real + synthetic corpora)
- 🚀 System optimization & performance tuning
- ☁️ **Backend deployment** (Google Cloud Run + Hugging Face Spaces) — *sole owner of this workstream*
</td>
<tr>
<table>

> Nearly every workstream — model development, backend engineering, AI pipeline design, dataset processing, and system optimization — was a **fully joint effort**. The one exception is **backend deployment**, which was owned and executed solely by **Venkata Sriram Topalli**.

---

## 📄 License

For Academic purpose only.

---

## 🔗 Links

| Resource | URL |
|---|---|
| Repository | https://github.com/AYUSHMSINGH2004/Audio-Forensics---AI-For-Voice-Security |
| Backend Demo | https://venkatasriram-audio-forensics-v8-1-demo.hf.space |

---

<div align="center">

### 🏁 Project Summary

Audio Forensics demonstrates a complete production-grade AI security pipeline for detecting synthetic voices and voice cloning attacks — combining transformer speech intelligence, signal-level forensic analysis, multilingual datasets, synthetic voice simulation, ensemble classification, and real-time inference.

*Detecting synthetic voices. Protecting authentic communication. Building safer voice AI.*

</div>
