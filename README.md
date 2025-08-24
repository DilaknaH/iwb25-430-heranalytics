# 🌱 Eco AI Agent

A sustainable carbon footprint calculator and environmental impact analyzer built with Ballerina and modern web technologies.

![Ballerina](https://img.shields.io/badge/Ballerina-2201.7.0-000000?style=for-the-badge&logo=ballerina)
![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-F7DF1E?style=for-the-badge&logo=javascript)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

## ✨ Features

- **Carbon Footprint Calculation** - Accurate CO₂ emissions calculations
- **RESTful API** - Built with Ballerina for high performance
- **Responsive Web Interface** - Modern HTML/CSS/JavaScript frontend
- **Real-time Analytics** - Environmental impact insights
- **Modular Architecture** - Scalable and maintainable codebase

## 🏗️ Architecture

```
Eco AI Agent
├── 📊 Backend (Ballerina)
│   ├── REST API Endpoints
│   ├── Carbon Calculation Engine
│   └── Data Validation
├── 🎨 Frontend (Vanilla JS)
│   ├── Responsive UI
│   ├── Form Handling
│   └── API Integration
└── 📚 Documentation
    ├── Setup Guides
    ├── API Documentation
    └── Architecture Overview
```

## 🚀 Quick Start

### Prerequisites
- Ballerina Swan Lake 2201.7.0+
- Web browser with JavaScript support
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DilaknaH/Eco-Ai-Agent.git
   cd eco-ai-agent
   ```

2. **Run the backend server**
   ```bash
   cd backend/ballerina
   bal run
   ```

3. **Access the application**
   - Backend API: http://localhost:9091/
   - Frontend: Open `frontend/index.html` in your browser

### API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/` | Welcome message |
| `GET` | `/health` | Service health check |
| `GET` | `/test` | Test endpoint |
| `POST` | `/carbon-footprint` | Calculate carbon footprint |

## 📁 Project Structure

```
eco-ai-agent/
├── backend/
│   └── ballerina/
│       ├── main.bal              # Main service entry point
│       ├── carbon_service.bal    # Carbon calculation logic
│       ├── carbon_api.bal        # API route definitions
│       ├── config.bal            # Configuration management
│       ├── Ballerina.toml        # Project dependencies
│       └── Config.toml           # Environment configuration
├── frontend/
│   ├── index.html                # Main application interface
│   ├── style.css                 # Styling and responsive design
│   └── script.js                 # Client-side functionality
├── docs/
│   ├── ARCHITECTURE.md           # System architecture
│   └── SETUP.md                  # Setup instructions
└── README.md                     # This file
```

## 🛠️ Development

### Building the Project

```bash
# Navigate to backend
cd backend/ballerina

# Build the project
bal build

# Run tests
bal test

# Format code
bal format
```

### Adding New Features

1. Add new Ballerina services in `/backend/ballerina/`
2. Update API endpoints in `carbon_api.bal`
3. Extend frontend functionality in `/frontend/`
4. Update documentation in `/docs/`

## 🌟 Key Technologies

- **Ballerina** - Type-safe, cloud-native programming language
- **Vanilla JavaScript** - Lightweight frontend without frameworks
- **Modern CSS** - Responsive design with Flexbox/Grid
- **REST Architecture** - Clean API design principles

## 📊 Calculation Methodology

The carbon footprint calculator uses industry-standard emission factors for:
- 🚗 Transportation (car travel, flights)
- 🏠 Energy consumption (electricity, gas)
- 🍖 Food consumption (meat, produce)
- 🛍️ Shopping and consumption

## 🤝 Contributing

We welcome contributions! Please see our contributing guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📚 [Documentation](docs/)
- 🐛 [Issue Tracker](https://github.com/DilaknaH/Eco-Ai-Agent/issues)
- 💬 [Discussions](https://github.com/DilaknaH/Eco-Ai-Agent/discussions)

## 🙏 Acknowledgments

- Built with [Ballerina](https://ballerina.io/)
- Emission factors based on industry research
- Inspired by sustainable technology initiatives

