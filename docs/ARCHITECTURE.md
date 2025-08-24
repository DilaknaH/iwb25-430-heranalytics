# Eco AI Agent - System Architecture

## 🏗️ Overall Architecture

```
Eco AI Agent System
├── 📱 Frontend (Web Interface)
├── 🔧 Backend (Ballerina API)
├── 🧠 AI/ML Components (Future)
├── 💾 Database Layer (Future)
└── 📊 Analytics & Reporting
```

## 🎯 System Components

### 1. Frontend Layer
**Technology:** HTML5, CSS3, JavaScript
**Location:** `/frontend/`
```
frontend/
├── index.html          # Main application page
├── style.css           # Styling and responsive design
├── script.js           # Client-side logic and API calls
└── assets/             # Images, icons, and static files
```

### 2. Backend Layer  
**Technology:** Ballerina Swan Lake
**Location:** `/backend/ballerina/`
```
backend/ballerina/
├── main.bal              # Main service and endpoints
├── carbon_service.bal    # Carbon calculation logic
├── carbon_api.bal        # API route definitions
├── config.bal            # Configuration management
├── emission_service.bal  # Emission factor database
├── validation.bal        # Input validation utilities
└── Ballerina.toml        # Project dependencies
```

### 3. API Endpoints Structure
```ballerina
service / on new http:Listener(9091) {
    # Core endpoints
    resource function get / → string                  # Welcome
    resource function get /health → json             # Health check
    resource function get /test → json               # Test endpoint
    
    # Carbon calculation endpoints (Future)
    resource function post /carbon-footprint → json  # Main calculation
    resource function get /emission-factors → json   # Get factors
    resource function get /analytics → json          # Usage statistics
}
```

## 🔄 Data Flow

### Request Flow:
1. **User Input** → Frontend Form Submission
2. **API Call** → Ballerina Backend (POST /carbon-footprint)
3. **Validation** → Input sanitization and verification
4. **Calculation** → Carbon footprint computation
5. **Response** → JSON data back to frontend
6. **Display** → Results rendered in UI

### Calculation Process:
```
User Data → [Validation] → [Emission Factors] → [Calculation Engine] → Results
```

## 🧮 Technical Stack

### Backend Framework
- **Ballerina Swan Lake** - Type-safe, cloud-native programming language
- **HTTP Services** - REST API endpoints
- **JSON Handling** - Data serialization/deserialization

### Frontend Stack
- **Vanilla JavaScript** - No framework dependencies
- **Modern CSS** - Flexbox/Grid for responsiveness
- **Fetch API** - HTTP requests to backend

### Development Tools
- **Ballerina CLI** - Build and execution
- **Git/GitHub** - Version control
- **VS Code** - Development environment

## 🏗️ Deployment Architecture

### Development Environment
```
Local Machine → Ballerina Runtime → Browser Testing
```

### Future Production Deployment
```
Cloud Server → Docker Container → Load Balancer → Multiple Instances
```

## 📈 Scalability Considerations

### Horizontal Scaling
- Stateless API design
- Multiple Ballerina service instances
- Load balancer configuration

### Performance Optimization
- Connection pooling
- Caching strategies
- Database indexing (future)

## 🔐 Security Architecture

### Current Implementation
- Input validation and sanitization
- Type-safe Ballerina endpoints
- CORS configuration for frontend-backend communication

### Future Enhancements
- JWT Authentication
- HTTPS encryption
- Rate limiting
- API key management

## 🗃️ Data Architecture (Planned)

### Database Schema
```sql
Users (user_id, email, created_at)
Calculations (calc_id, user_id, footprint, timestamp, categories)
EmissionFactors (factor_id, category, value, unit)
```

### Storage Strategy
- PostgreSQL for relational data
- JSON storage for calculation results
- Environment-specific configurations

## 🚀 Future Architecture Enhancements

### Machine Learning Integration
- Predictive carbon footprint modeling
- Personalized sustainability recommendations
- Anomaly detection in usage patterns

### Microservices Expansion
```
Authentication Service → User Management
Calculation Service → Carbon Algorithms
Analytics Service → Data Processing
Notification Service → Alerts & Reports
```

## 📊 Monitoring & Analytics

### Logging Strategy
- Structured logging with Ballerina log module
- Request/response tracking
- Error monitoring and alerting

### Performance Metrics
- API response times
- Calculation processing time
- System health metrics


