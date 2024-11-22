
# Automatic Modulation Recognition (AMR) System

## Overview
This project tackles the critical challenge of accurately classifying modulation types in telemetry, tracking, and command (TTC) systems, particularly in low carrier-to-noise density ratio (CNR) environments. By leveraging AI/ML techniques and FPGA-based hardware, the system achieves real-time signal recognition and efficient data processing, ensuring reliable communication.

---

## Key Features
- **AI/ML-Based Modulation Classification:** Combines CNN and LSTM layers for high accuracy (>92%) over a signal-to-noise ratio (SNR) range of [0,18].
- **Threshold-Based Logic:** Implements predefined signal characteristics for fast, real-time decision-making.
- **FPGA Integration:** Utilizes a PYNQ-Z2 FPGA for efficient, low-latency signal classification.

---

## Problem Statement
Traditional AMR systems face challenges in low CNR environments due to:
1. **Low Accuracy:** High noise levels degrade signal quality.
2. **High Computational Complexity:** Resource-intensive algorithms hinder real-time applications.
3. **Limited Signal Identification:** Inability to handle complex distortions.

---

## Proposed Solution
### Dual-Approach Strategy:
1. **AI/ML-Based Approach:**
   - **Model:** CNN + LSTM with ~108k parameters.
   - **Dataset:** DeepSig RadioML 2016.10A dataset with 11 modulation types.
   - **Accuracy:** >92% for SNR [0,18].

2. **Threshold-Based Approach:**
   - Utilizes lightweight logic for real-time classification.
   - Achieves >95% accuracy with minimal computational overhead.

---

### FPGA Implementation
- **Advantages:**
  - **Parallel Processing:** Enables real-time operation.
  - **Flexibility:** Supports reconfiguration for evolving requirements.
  - **Low Latency:** Ensures processing delays of <100ms.

---

## Benefits
- **Enhanced Data Accuracy:** Reliable modulation classification minimizes errors.
- **Real-Time Processing:** Low-latency FPGA implementation ensures rapid decision-making.
- **Scalability:** Adaptable to diverse modulation schemes and communication systems.
- **Energy Efficiency:** Runs on 5V, consuming 40% less power than alternatives.

---

## Applications
- **Aerospace & Defense:** Real-time secure communication and signal intelligence.
- **Telecommunications:** Supports 5G/6G networks with efficient spectrum usage.
- **IoT:** Reliable communication in dense, connected environments.
- **Autonomous Systems:** Ensures robust communication for vehicles and drones.

---

## Implementation Details
### Steps:
1. Develop AI/ML algorithms using CNN and LSTM.
2. Validate models on MATLAB simulations and the DeepSig dataset.
3. Implement algorithms on FPGA using HDL.
4. Test and benchmark the system for real-time performance.

### Hardware:
- **Primary Device:** PYNQ-Z2 FPGA
- **Possible Alternative:** Nvidia Jetson Nano for hybrid deployment.

---

## Results
- **ML Model Accuracy:** >92% on SNR range [0,18].
- **Thresholding Approach Accuracy:** >95% for selected modulation schemes.
- **Latency:** <100ms processing time.
- **Power Efficiency:** Operates smoothly on 5V.

---

## Team
- **Team Members:** Bharat Agarwal,Saurabh Singh, Yash Verma, Rudraksh Lande, Karan Seth, Mohit  
- **Mentors:** Dr. Robin Khosla, Nikhil Chauhan  

---

## Future Work
- **I/O Device Integration:** Adding input and output interfaces for direct interaction with the FPGA.
- **Model Deployment:** Optimizing the ML model for FPGA compatibility.
- **Testing & Benchmarking:** Validating the system under diverse real-world conditions.

---

## License
This project is licensed under WTFPL.

For any inquiries, feel free to contact us.
