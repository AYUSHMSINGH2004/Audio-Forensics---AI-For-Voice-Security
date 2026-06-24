# 🎙️ Audio Forensics: AI for Voice Security

<p align="center">

<img src="https://img.shields.io/badge/AI-Voice%20Security-blue">
<img src="https://img.shields.io/badge/Deepfake-Detection-red">
<img src="https://img.shields.io/badge/Backend-FastAPI-green">
<img src="https://img.shields.io/badge/Model-Version%208.1-purple">

</p>

## 🛡️ Production-Grade AI Voice Deepfake Detection System

Audio Forensics is an AI-powered voice security platform designed to detect synthetic speech, AI-generated voices, and voice cloning attacks.

The system evolved through **8+ model generations**, moving from traditional spectrogram-based deep learning into a production forensic engine combining:

* Transformer speech representations
* Signal-processing based forensic features
* Siamese similarity learning
* Ensemble machine learning
* Real-time WebSocket inference

The platform supports:

✅ Static audio forensic analysis
✅ Real-time voice interception simulation
✅ AI-generated speech detection
✅ Threat scoring
✅ Operator-friendly forensic reports

---

# 🚀 Live Deployment

## Production Deployment (Google Cloud Run)

The original production deployment was hosted on Google Cloud Run.

Cloud Run was selected because the complete infrastructure was inside the Google Cloud ecosystem.

Deployment stack:

* Docker
* FastAPI
* PyTorch Runtime
* WavLM
* Whisper
* LightGBM
* Google Cloud Container Registry

Original Cloud Run endpoint:

```
https://threat-engine-v8-810126162948.us-central1.run.app/
```

The Cloud Run deployment was successfully tested and used as the primary production environment.

However, since the service was running continuously, Google Cloud resources continued consuming billing credits.

Therefore, the Cloud Run instance was shut down after validation.

---

# 🌐 Current Public Demo Deployment

For public accessibility, the backend has been redeployed using Hugging Face Spaces.

Live Backend:

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```

Current deployment provides:

* Static audio analysis API
* Live WebSocket streaming
* V8.1 forensic inference engine

---

# 🧠 System Pipeline Overview

```
                 Audio Input

                      |

        +-------------+-------------+

        Static Upload          Live Stream

              |                     |

          REST API             WebSocket

              |                     |

              +----------+----------+

                         |

              V8.1 Audio Forensic Engine

                         |

        +----------------+----------------+

        |                                 |

   WavLM Embeddings              LFCC Features

        |                                 |

        +----------------+----------------+

                         |

              Feature Fusion Layer

                         |

                  LightGBM Classifier

                         |

              Threat Intelligence Report

```

---

# 📂 Repository Structure

```
Audio-Forensics---AI-For-Voice-Security

│
├── Backend
│   ├── V_8_Production
│   └── V_8_1_Production
│
├── Frontend
│
├── Data Preprocessing
│
├── Untitled.ipynb
│
├── live_stream_tester_v8_1.py
│
└── README.md

```

---

# 📊 Dataset Engineering & Data Pipeline

Data quality is one of the most important components of this project.

The model is trained on a carefully engineered combination of:

* Real human speech
* Synthetic AI-generated speech
* Multilingual speech samples
* Multiple TTS generation styles

The objective was not only to detect obvious synthetic audio, but also:

* Voice cloning
* Neural TTS artifacts
* Compression artifacts
* Telephonic degradation
* Cross-language synthetic speech

---

# 🌍 Real Speech Dataset Pipeline

The real speech pipeline uses multilingual speech sources similar to Common Voice style datasets.

Processing flow:

```
Raw Dataset Archive

        |

Language Filtering

        |

Speaker Validation

        |

Audio Extraction

        |

Normalization

        |

Training Dataset

```

---

## Language Identification

Because the dataset contains multiple languages, language filtering is performed before training.

Techniques:

* GlotLID language identification
* Whisper-based verification

Purpose:

* Remove incorrect language samples
* Improve multilingual robustness
* Prevent noisy labels

---

# 🤖 Synthetic Voice Dataset Generation

To make the detector robust against modern AI voices, synthetic samples were generated using multiple TTS systems.

Synthetic sources include:

### OpenAI Voice Generation

Used for high-quality neural synthetic voices.

### Google Cloud Text-To-Speech

Used for cloud-generated speech diversity.

### Coqui XTTSv2

Used for:

* Voice cloning simulation
* Speaker similarity testing

### Microsoft Edge TTS

Used for additional synthetic diversity.

### gTTS / eSpeak

Used as fallback generators for additional variation.

---

# 🔊 Audio Preprocessing Pipeline

Every audio sample passes through:

```
Input Audio

     |

Format Validation

     |

Resampling

     |

Mono Conversion

     |

Noise Filtering

     |

Silence Removal

     |

Chunk Generation

     |

Feature Extraction

```

---

## Standard Audio Format

All training and inference audio is normalized to:

```
Sample Rate : 16000 Hz

Channels    : Mono

Format      : WAV

```

This ensures consistency between:

* Training
* Validation
* Deployment

---

# 🧹 Cleaning & Filtering

Preprocessing removes:

* Corrupted files
* Empty recordings
* Extremely short clips
* Invalid formats
* Incorrect language samples

Techniques used:

* FFmpeg conversion
* RMS energy filtering
* Silence trimming
* Validation scripts

---

# 🎛️ Data Augmentation

To simulate real-world attacks, the dataset includes:

## Noise Injection

Simulates:

* Background noise
* Recording environments

## Time Masking

Inspired by SpecAugment.

## Frequency Masking

Improves robustness against:

* Compression
* Band limitations

## Telephonic Simulation

Includes:

* Band-pass filtering
* Codec-like degradation
* Channel distortion

---

# 🔬 Feature Extraction

Different model generations use different representations.

## Mel Spectrograms

Used in early CRNN models.

Captures:

* Frequency patterns
* Spectral artifacts

---

## Wav2Vec2 Embeddings

Used in Version 4+.

Advantages:

* Learns speech representations
* Captures high-level acoustic information

---

## WavLM Embeddings

Used in Version 7 and Version 8.

Captures:

* Speaker characteristics
* Speech structure
* Synthetic artifacts

---

## LFCC Features

Used in Version 8.1.

Captures:

* Micro spectral differences
* Frequency inconsistencies

---

# 🧬 Model Evolution

| Version | Architecture              | Main Contribution         |
| ------- | ------------------------- | ------------------------- |
| V1      | CRNN + Mel Spectrogram    | Initial baseline          |
| V2      | Augmented CRNN            | Robustness improvement    |
| V3      | Hybrid CRNN               | Better generalization     |
| V4      | Wav2Vec2 + XGBoost        | Transformer transition    |
| V5      | Production Wrapper        | API + Streaming           |
| V6      | Wav2Vec2 + LFCC + XGBoost | Forensic features         |
| V7      | Siamese WavLM             | Voice similarity learning |
| V8      | WavLM DNA + XGBoost       | Production classifier     |
| V8.1    | WavLM + LFCC + LightGBM   | Final forensic engine     |

---

# ⭐ Version 8.1 Production Model

Architecture:

```
Audio

 |

WavLM Encoder

 +

LFCC Extraction

 |

848 Dimension Feature Vector

 |

LightGBM

 |

Threat Classification

```

Reported Accuracy:

```
99.84%
```

---

# 🧪 Testing

## Static Analysis

Endpoint:

```
POST /analyze
```

Example:

```python
import requests


url="https://venkatasriram-audio-forensics-v8-1-demo.hf.space/analyze"


files={
"file":open("sample.wav","rb")
}


response=requests.post(url,files=files)

print(response.json())

```

Returns:

* Threat status
* AI probability
* Human probability
* Language
* Action report

---

# 🎧 Live Streaming Testing

File:

```
live_stream_tester_v8_1.py
```

Install:

```
pip install websockets librosa numpy nest_asyncio
```

Update:

```python
uri="wss://venkatasriram-audio-forensics-v8-1-demo.hf.space/ws/stream"
```

Set:

```python
TEST_FILE="sample.wav"
```

Run:

```
python live_stream_tester_v8_1.py
```

The script:

1. Loads audio
2. Converts to 16kHz mono
3. Splits into 0.5 second chunks
4. Streams through WebSocket
5. Receives live predictions
6. Prints final forensic report

---

# 🖥️ Frontend

Built using:

* React
* Vite
* Tailwind CSS
* shadcn/ui
* WebSockets
* Firebase

Features:

* Authentication
* Analysis history
* Operator dashboard
* Threat visualization

---

# 🔒 Frontend Deployment Status

The frontend is intentionally not publicly deployed.

Reason:

The application stores:

* User history
* Authentication information
* Analysis records

through Firebase.

Public deployment without additional security hardening could expose Firebase configuration and sensitive workflows.

Therefore:

✅ Backend → Publicly deployed
✅ AI Engine → Accessible
❌ Frontend → Local/private deployment only

---

# 👥 Contributors

* **Ayush M Singh**

  * Model development
  * Backend engineering
  * Deployment
  * System architecture

(Add remaining contributors)

---

# 🔗 Links

Repository:

```
https://github.com/AYUSHMSINGH2004/Audio-Forensics---AI-For-Voice-Security
```

Backend:

```
https://venkatasriram-audio-forensics-v8-1-demo.hf.space
```

---

# ⚠️ Notes

* Do not upload datasets publicly.
* Do not commit Firebase credentials.
* Do not commit model weights without Git LFS.
* Version 5 is an inference wrapper around Version 4.
* Version 8.1 is the final production engine.

---

<p align="center">

Built for AI-powered voice security and deepfake defense.

</p>
