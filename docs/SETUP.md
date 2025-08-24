# Eco AI Agent - Setup Guide

## 🚀 Quick Start

### Prerequisites
- **Ballerina Swan Lake** 2201.7.0 or later
- **Git** for version control
- **Web Browser** (Chrome, Firefox, Safari, or Edge)
- **VS Code** (recommended) with Ballerina extension

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/DilaknaH/Eco-Ai-Agent.git
   cd eco-ai-agent
   ```

2. **Navigate to Backend**
   ```bash
   cd backend/ballerina
   ```

3. **Run the Application**
   ```bash
   bal run
   ```

4. **Access the Application**
   Open your browser and go to: http://localhost:9091/

## 📋 Detailed Setup Instructions

### 1. Ballerina Installation

#### Windows
```bash
# Download from: https://ballerina.io/downloads/
# Or use Chocolatey:
choco install ballerina
```

#### macOS
```bash
# Using Homebrew:
brew update
brew install ballerina
```

#### Linux
```bash
# Download the installer from ballerina.io
# Or use package managers for specific distributions
```

Verify installation:
```bash
bal version
# Should show: Ballerina 2201.7.0 (Swan Lake) or later
```

### 2. Project Structure Overview
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
│   ├── index.html                # Main web interface
│   ├── style.css                 # Styling
│   └── script.js                 # Client-side logic
└── docs/
    ├── ARCHITECTURE.md           # System architecture
    └── SETUP.md                  # This file
```

### 3. Configuration

#### Environment Setup
Create or edit `Config.toml` in the backend directory:
```toml
# Server configuration
server.port = 9091

# API settings (future use)
api.version = "1.0.0"
api.environment = "development"

# CORS settings (for frontend-backend communication)
cors.allowed_origins = ["http://localhost:5500", "http://127.0.0.1:5500"]
```

### 4. Running the Application

#### Development Mode
```bash
# Navigate to backend directory
cd backend/ballerina

# Run with auto-reload (development)
bal run
```

#### Production Build
```bash
# Build the project
bal build

# Run the generated JAR
java -jar target/bin/ballerina.jar
```

### 5. Testing the Setup

#### Verify Backend is Running
```bash
# Test health endpoint
curl http://localhost:9091/health

# Expected response:
# {"status":"healthy","serviceName":"carbon-footprint","version":"1.0.0"}
```

#### Test Frontend (when implemented)
1. Open `frontend/index.html` in a web browser
2. Or use a local server:
   ```bash
   cd frontend
   python -m http.server 5500
   ```
3. Open: http://localhost:5500

### 6. Development Workflow

#### Adding New Features
1. Create new Ballerina service files in `/backend/ballerina/`
2. Update API endpoints in `carbon_api.bal`
3. Add business logic in `carbon_service.bal`
4. Test with:
   ```bash
   bal run
   ```

#### Code Formatting
```bash
# Format Ballerina code
bal format
```

#### Dependency Management
```bash
# Add new dependencies (if needed)
bal add ballerina/<module_name>
```

## 🐛 Troubleshooting

### Common Issues

#### Port Already in Use
```bash
# Error: "Address already in use: bind"
# Solution: Change port in Config.toml or kill existing process
netstat -ano | findstr :9091
taskkill /PID <process_id> /F
```

#### Ballerina Not Found
```bash
# Error: "bal: command not found"
# Solution: Add Ballerina to PATH or reinstall
```

#### Module Import Errors
```bash
# Error: "undefined module"
# Solution: Check Ballerina.toml and run:
bal clean
bal build
```

### Getting Help

1. **Check Ballerina Documentation**: https://ballerina.io/learn/
2. **Review API Documentation**: See `docs/API.md`
3. **Examine Error Logs**: Check terminal output for detailed errors

## 🔧 Development Tools

### Recommended VS Code Extensions
- **Ballerina Extension** - Language support
- **REST Client** - API testing
- **GitLens** - Git integration

### Useful Commands
```bash
# Check project status
bal build --offline

# Run tests (when implemented)
bal test

# Check for vulnerabilities
bal audit
```

## 📦 Deployment (Future)

### Docker Deployment
```dockerfile
FROM ballerina/ballerina:2201.7.0
COPY target/bin/ballerina.jar /app/
CMD ["java", "-jar", "/app/ballerina.jar"]
```

### Cloud Deployment Options
- AWS Lambda
- Google Cloud Run
- Azure Container Apps
- DigitalOcean App Platform

