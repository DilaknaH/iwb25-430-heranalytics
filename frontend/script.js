document.getElementById("carbonForm").addEventListener("submit", (e) => {
    e.preventDefault();

    // Get values (default to 0 if empty)
    let carKm = parseFloat(document.getElementById("carDistance").value) || 0;
    let electricity = parseFloat(document.getElementById("electricity").value) || 0;
    let flights = parseFloat(document.getElementById("flights").value) || 0;
    let meat = parseFloat(document.getElementById("meat").value) || 0;
    let gas = parseFloat(document.getElementById("gas").value) || 0;
    let shopping = parseFloat(document.getElementById("shopping").value) || 0;

    // Example CO₂ emission factors
    let carEmission = carKm * 0.12;             
    let electricityEmission = electricity * 0.4; 
    let flightEmission = flights * 250;         
    let meatEmission = meat * 27;               
    let gasEmission = gas * 0.2;                
    let shoppingEmission = shopping * 0.1;      

    // Total footprint
    let total = (carEmission + electricityEmission + flightEmission + meatEmission + gasEmission + shoppingEmission).toFixed(2);

    // Find the largest contributor
    let emissions = {
        "car": carEmission,
        "electricity": electricityEmission,
        "flights": flightEmission,
        "meat": meatEmission,
        "gas": gasEmission,
        "shopping": shoppingEmission
    };

    let maxSource = Object.keys(emissions).reduce((a, b) => emissions[a] > emissions[b] ? a : b);

    // Generate relevant suggestion
    let suggestion = "";
    switch(maxSource) {
        case "car":
            suggestion = "Reduce car travel or switch to public transport/electric vehicles!";
            break;
        case "electricity":
            suggestion = "Save energy with LED bulbs, efficient appliances, and renewable sources!";
            break;
        case "flights":
            suggestion = "Cut down on flights or choose train travel for lower emissions!";
            break;
        case "meat":
            suggestion = "Try reducing meat consumption and include more plant-based meals!";
            break;
        case "gas":
            suggestion = "Improve insulation or switch to renewable heating to cut gas use!";
            break;
        case "shopping":
            suggestion = "Reduce unnecessary shopping and buy sustainable products!";
            break;
    }

    // Show output
    document.getElementById("result").innerHTML = `
        <h3>🌍 Your Estimated Carbon Footprint: ${total} kg CO₂</h3>
        <p>💡 Suggestion: ${suggestion}</p>
    `;
});



