# AIoT All-in-One

Welcome to the **AIoT All-in-One** project! This repository serves as a comprehensive framework and codebase for Artificial Intelligence of Things (AIoT) applications. It is designed to bridge the gap between IoT hardware devices, edge computing, cloud services, and AI/ML intelligence.

---

## 🚀 Key Features

* **Edge Intelligence**: Deploy lightweight AI/ML models on edge devices for real-time inference.
* **IoT Device Management**: Connect, monitor, and control various IoT sensors and actuators.
* **Data Analytics**: Collect and analyze telemetry data using modern data visualization techniques.
* **Cloud Integration**: Synchronize local/edge data to cloud databases and remote servers.
* **Interactive Dashboard**: A beautiful, user-friendly control panel to manage the entire AIoT system.

---

## 🛠️ Project Structure

As the repository grows, it is organized into the following modules:

```text
aiot/
├── config/             # Configuration files for devices, databases, and servers
├── edge/               # Scripts and models running on edge gateways/devices (e.g., Raspberry Pi)
├── dashboard/          # Web dashboard (HTML/CSS/JS frontend & backend API)
├── models/             # Pre-trained and custom AI/ML model definitions/weights
├── scripts/            # Setup, deployment, and testing utilities
└── README.md           # Project documentation
```

---

## 🏁 Getting Started

### Prerequisites

* **Node.js** (v18 or higher) for the dashboard/backend server
* **Python** (v3.9 or higher) for AI/ML inference and edge scripts
* **Git** for version control
* **XAMPP / PHP / MySQL** (optional, depending on database requirements)

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/huanchen1107/AIoTAllinOne.git
   cd AIoTAllinOne
   ```

2. Install dependencies:
   * For the dashboard:
     ```bash
     cd dashboard
     npm install
     ```
   * For python/edge requirements:
     ```bash
     pip install -r edge/requirements.txt
     ```

---

## 📅 Recent Updates
### 2026-07-27
- Added project rule and timestamp logging logic.


### 2026-07-27
- Created ending.sh script

---


## 🤝 Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests for improvements, bug fixes, or new features.

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
