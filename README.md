Eco AI Agent 🤖🌿

A web-based Eco-AI Agent that calculates your personal carbon footprint and provides AI-generated, eco-friendly suggestions. Built with HTML, CSS, JavaScript, and a Ballerina backend for robust calculations.

🚀 Features

Input your daily/weekly environmental habits (car travel, electricity, flights, meat consumption, gas usage, shopping) to calculate your carbon footprint.

Provides personalized suggestions to reduce emissions based on your highest-impact activities.

Smooth landing screen with gradient and background image overlay.

Ballerina backend integration for accurate carbon footprint calculations, with fallback client-side calculation if the backend is unavailable.

Responsive design for mobile and desktop devices.

📋 Prerequisites

Ballerina Swan Lake: Install the Ballerina
 programming language.

Web Browser: Chrome, Edge, or Firefox for testing the web app.

Optional: OpenAI API key if extending the app for AI-powered advice.

⚙️ Setup Instructions
1. Clone the Repository
git clone https://github.com/DilaknaH/Eco-Ai-Agent.git
cd Eco-Ai-Agent/frontend

2. Run the Frontend

You can open the index.html file directly in a web browser for testing.

3. Run the Ballerina Backend (Optional)

The app uses a Ballerina backend for calculations. To run:

cd ../backend
bal run


The backend service runs at http://localhost:9090/ecoai/.

4. Test the App

Open the web page in a browser.

Click Start on the landing screen.

Enter your daily/weekly environmental data.

Click Calculate Footprint.

The app will display your total estimated carbon footprint with suggestions.

If the Ballerina backend is offline, a client-side fallback calculation will be used automatically.

🔧 Configuration

If you want to customize the background image, edit the body CSS in style.css:

body {
    background: linear-gradient(135deg, rgba(11,61,38,0.85) 0%, rgba(26,107,69,0.85) 100%),
                url("background.jpg") no-repeat center center fixed;
    background-size: cover;
}


To adjust emission factors or suggestions, modify the JS file main.js:

const carEmission = carKm * 0.12;
const electricityEmission = electricity * 0.4;
const flightEmission = flights * 250;
const meatEmission = meat * 27;
const gasEmission = gas * 0.2;
const shoppingEmission = shopping * 0.1;

💡 Usage

Fill in your daily/weekly inputs for car distance, electricity, flights, meat, gas, and shopping.

Click Calculate Footprint.

Review your total carbon footprint and AI-generated suggestions.

Click Reset Form to start over.

🖥️ Responsive Design

Mobile-friendly layout with flexible form elements and buttons.

Transparent content box overlays the background with blur effect for readability.

⚠️ Notes

The Ballerina backend must be running locally at http://localhost:9090/ecoai/ for backend calculations.

If backend is unavailable, the app falls back to client-side calculation automatically.

All animations (fade-in, fade-up) and landing page effects are handled via CSS.


