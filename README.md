# Audio Forensics: AI for Voice Security 🎙️🛡️

A multi-stage AI-powered audio deepfake detection and voice security platform designed to identify synthetic speech attacks, analyze suspicious voice activity, and provide forensic threat intelligence for both uploaded audio and real-time streaming scenarios.

The project evolved from a research-based spectrogram classifier into a production-grade voice security engine using transformer-based speech representations, forensic signal analysis, Siamese learning, and optimized inference pipelines.

---

# 🚀 Project Overview

Modern AI voice generation systems can create highly realistic synthetic speech. This creates security risks in:

* Voice authentication attacks
* Scam calls
* Impersonation attempts
* Social engineering
* Synthetic media misuse

Audio Forensics addresses this problem by analyzing acoustic artifacts, speech embeddings, and forensic signal patterns to classify whether audio is:

* ✅ Authentic Human Speech
* 🚨 AI Generated / Synthetic Speech

---

# ✨ Key Features

## Static Audio Analysis

Upload an audio file and receive:

* AI probability score
* Human probability score
* Threat classification
* Language detection
* Latency information
* Security action report

Supported formats:

```
.wav
.mp3
.flac
.ogg
.mp4
```

---

## Real-Time Live Audio Interception

The system supports:

* WebSocket-based streaming
* Live chunk analysis
* Rolling threat updates
* Final cumulative forensic report

Designed for:

* Live call monitoring
* Voice security systems
* Real-time fraud detection

---

# 🏗️ System Architecture

```
                Audio Input
                    |
                    |
        +-----------+-----------+
        |                       |
 Static Upload            Live Stream
        |                       |
        |                       |
 FastAPI REST API        WebSocket API
        |                       |
        +-----------+-----------+
                    |
            V8.1 Forensic Engine
                    |
        +-----------+-----------+
        |
        |
  WavLM Embeddings
        +
  LFCC Forensic Features
        |
        |
 LightGBM Threat Classifier
        |
        |
 Threat Intelligence Report
```

---

# 📂 Repository Structure

```
Audio-Forensics---AI-For-Voice-Security

│
├── Backend/
│   ├── V_8_Production/
│   └── V_8_1_Production/
│
├── Frontend/
│
├── Data Preprocessing/
│
├── Untitled.ipynb
│
├── live_stream_tester_v8_1.py
│
└── README.md
```

---

# 🔬 Data Preprocessing Pipeline

The preprocessing pipeline converts raw speech into forensic-ready training data.

## Audio Collection

Sources include:

* Real multilingual speech datasets
* Synthetic TTS generated voices

Synthetic generation engines:

* OpenAI TTS
* Google Cloud TTS
* Coqui XTTSv2
* Microsoft Edge TTS
* gTTS
* eSpeak

---

## Audio Standardization

All audio is converted into a common format:

```
Sample Rate : 16000 Hz
Channels    : Mono
Format      : WAV
```

Processing includes:

* Resampling
* Noise handling
* Silence removal
* Chunking
* Padding
* Corrupted file filtering

---

# 🧠 Model Evolution

## Version 1 — CRNN Baseline

Architecture:

```
Mel Spectrogram
        |
Modified ResNet18
        |
BiLSTM
        |
Classifier
```

Techniques:

* Mel spectrogram extraction
* CNN feature extraction
* Temporal sequence modeling

Purpose:

Created the first deepfake detection baseline.

---

# Version 2 — Robust CRNN

Added:

* Noise augmentation
* Frequency masking
* Time masking
* Stronger regularization

Goal:

Improve robustness against real-world audio degradation.

---

# Version 3 — Hybrid Augmentation CRNN

Added:

* Probabilistic augmentation
* Reverberation simulation
* Analog channel effects

Improved:

* Generalization
* Noisy audio performance

---

# Version 4 — Wav2Vec2 + XGBoost

Major architectural shift.

Pipeline:

```
Raw Audio
    |
Wav2Vec2
    |
768D Embedding
    |
XGBoost Classifier
```

Added:

* Transformer speech embeddings
* Whole clip inference
* Whisper language detection

---

# Version 5 — Production Wrapper

Version 5 converted Version 4 into an API system.

Added:

* FastAPI backend
* ONNX Runtime inference
* REST API
* WebSocket streaming

Endpoints:

```
POST /analyze

WS /ws/stream

GET /
```

---

# Version 6 — Forensic Feature Fusion

Added handcrafted forensic analysis.

Features:

* Wav2Vec2 embeddings
* LFCC features
* Phase difference analysis
* Phase jitter statistics

Classifier:

```
Wav2Vec2 + Forensic Features
              |
          XGBoost
```

---

# Version 7 — Siamese WavLM Network

Introduced similarity learning.

Architecture:

```
Audio A
   |
 WavLM
   |
Embedding


Audio B
   |
 WavLM
   |
Embedding


Difference Vector
        |
Classifier
```

Used for:

* Voice cloning detection
* Similarity-based verification

---

# Version 8 — WavLM DNA Classifier

Pipeline:

```
Full Audio
    |
Sliding Windows
    |
WavLM Embeddings
    |
DNA Vector
    |
XGBoost
```

Reported Accuracy:

```
99.71%
```

---

# Version 8.1 — Production Model ⭐

Latest production engine.

Architecture:

```
                 Audio

                    |
        +-----------+-----------+

        WavLM Embeddings

                    +

        LFCC Forensic Features

                    |

          848 Dimension Vector

                    |

              LightGBM

                    |

          Threat Classification
```

Features:

* Transformer speech representation
* Signal-level forensic analysis
* Telephonic augmentation
* Whole clip analysis
* Cached embeddings

Reported Accuracy:

```
99.84%
```

---

# 🚀 Deployment

## Primary Deployment — Google Cloud Run

The original production deployment was made using Google Cloud Run because the entire infrastructure was hosted inside our Google Cloud environment.

Deployment stack:

* Docker
* FastAPI
* PyTorch Runtime
* WavLM
* Whisper
* LightGBM

Original production endpoint:

```
https://threat-engine-v8-810126162948.us-central1.run.app/
```

However, Cloud Run resources were shut down after testing because keeping the service active continuously resulted in ongoing Google Cloud billing charges.

---

# Current Demo Deployment — Hugging Face Spaces

For public demonstration and testing, the backend has been redeployed on Hugging Face Spaces.

Live Backend:

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```

The deployed backend provides:

* Static audio analysis
* Live WebSocket streaming
* V8.1 inference pipeline

---

# 🧪 Testing Static Audio Analysis

Use the deployed backend:

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```

Send an audio file through:

```
POST /analyze
```

Example:

```python
import requests

url="https://venkatasriram-audio-forensics-v8-1-demo.hf.space/analyze"

files={
    "file":open("test.wav","rb")
}

response=requests.post(url,files=files)

print(response.json())
```

Response includes:

* Threat status
* AI probability
* Human probability
* Language
* Action report

---

# 🎧 Live Stream Testing

The repository contains:

```
live_stream_tester_v8_1.py
```

This simulates microphone input locally.

Install:

```bash
pip install websockets librosa numpy nest_asyncio
```

Update:

```python
uri =
"wss://venkatasriram-audio-forensics-v8-1-demo.hf.space/ws/stream"
```

Set your test file:

```python
TEST_FILE="sample.wav"
```

Run:

```bash
python live_stream_tester_v8_1.py
```

The script:

1. Loads audio
2. Converts it to 16kHz mono
3. Splits audio into 0.5 second chunks
4. Streams chunks through WebSocket
5. Receives live threat updates
6. Prints final forensic report

Example output:

```
[LIVE]

Status: Suspicious

Human: 12%
AI: 88%

Latency: 240ms
```

Final output:

```
FINAL V8.1 CUMULATIVE THREAT REPORT
```

---

# Frontend Deployment Status

The frontend has not been publicly deployed.

Reason:

The frontend integrates Firebase for:

* Authentication
* User analysis history
* Stored forensic reports

Public deployment without additional security hardening could expose sensitive Firebase configuration and user data workflows.

Therefore:

✅ Backend deployed
✅ AI inference publicly available
❌ Frontend remains private/local

---

# Running Frontend Locally

```bash
cd Frontend

npm install

npm run dev
```

Configure:

```
.env.local
```

with Firebase credentials.

Never commit Firebase secrets.

---

# Contributors

* Ayush M Singh — Project Lead, Model Development, Backend Integration

(Add remaining team members)

---

# Important Notes

* Version 5 is a production wrapper around Version 4.
* Version 8.1 is the latest production inference engine.
* Training datasets and model weights should not be pushed publicly.
* Remove all secrets before deployment.

---

# Project Links

Repository:

```
https://github.com/AYUSHMSINGH2004/Audio-Forensics---AI-For-Voice-Security
```

Live Backend:

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```
