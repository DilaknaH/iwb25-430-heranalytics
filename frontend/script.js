document.getElementById("carbonForm").addEventListener("submit", (e) => {
    e.preventDefault();

    // Show loading indicator
    const loading = document.getElementById("loading");
    loading.style.display = "block";

    // Get input values (default to 0 if empty)
    const carKm = parseFloat(document.getElementById("carDistance").value) || 0;
    const electricity = parseFloat(document.getElementById("electricity").value) || 0;
    const flights = parseFloat(document.getElementById("flights").value) || 0;
    const meat = parseFloat(document.getElementById("meat").value) || 0;
    const gas = parseFloat(document.getElementById("gas").value) || 0;
    const shopping = parseFloat(document.getElementById("shopping").value) || 0;

    // CO₂ emission factors (example fallback calculation)
    const carEmission = carKm * 0.12;             
    const electricityEmission = electricity * 0.4; 
    const flightEmission = flights * 250;         
    const meatEmission = meat * 27;               
    const gasEmission = gas * 0.2;                
    const shoppingEmission = shopping * 0.1;      

    // Total carbon footprint
    const total = (
        carEmission +
        electricityEmission +
        flightEmission +
        meatEmission +
        gasEmission +
        shoppingEmission
    ).toFixed(2);

    // Determine the largest contributor
    const emissions = { car: carEmission, electricity: electricityEmission, flights: flightEmission, meat: meatEmission, gas: gasEmission, shopping: shoppingEmission };
    const maxSource = Object.keys(emissions).reduce((a, b) => emissions[a] > emissions[b] ? a : b);

    // Generate relevant suggestion
    let suggestion = "";
    switch (maxSource) {
        case "car": suggestion = "🚗 Reduce car travel or switch to public transport/electric vehicles!"; break;
        case "electricity": suggestion = "💡 Save energy with LED bulbs, efficient appliances, and renewable sources!"; break;
        case "flights": suggestion = "✈️ Cut down on flights or choose train travel for lower emissions!"; break;
        case "meat": suggestion = "🍃 Try reducing meat consumption and include more plant-based meals!"; break;
        case "gas": suggestion = "🔥 Improve insulation or switch to renewable heating to cut gas use!"; break;
        case "shopping": suggestion = "🛍️ Reduce unnecessary shopping and buy sustainable products!"; break;
    }

    // Update background transparency of content box
    document.querySelector(".content").style.background = "rgba(0, 0, 0, 0.35)";

    // Show results
    const resultContainer = document.getElementById("result");
    resultContainer.innerHTML = `
        <div class="result-container">
            <h3>🌍 Your Estimated Carbon Footprint: ${total} kg CO₂</h3>
            <p>${suggestion}</p>
        </div>
    `;

    // Hide loading indicator
    loading.style.display = "none";

    // Smooth scroll to result
    resultContainer.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
});
