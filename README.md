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

- Transformer speech representations
- Signal-processing based forensic features
- Siamese similarity learning
- Ensemble machine learning
- Real-time WebSocket inference

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

- Docker
- FastAPI
- PyTorch Runtime
- WavLM
- Whisper
- LightGBM
- Google Cloud Container Registry

Original Cloud Run endpoint:

```text
https://threat-engine-v8-810126162948.us-central1.run.app/
