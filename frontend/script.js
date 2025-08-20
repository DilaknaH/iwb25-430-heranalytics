document.getElementById("carbonForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    // Get values (ensure IDs match HTML IDs)
    const carDistance = document.getElementById("carDistance").value;
    const electricity = document.getElementById("electricity").value;
    const flights = document.getElementById("flights").value;
    const meat = document.getElementById("meat").value;
    const gas = document.getElementById("gas").value;
    const shopping = document.getElementById("shopping").value;

    try {
        const response = await fetch("http://localhost:9090/calculate", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                carDistance,
                electricity,
                flights,
                meat,
                gas,
                shopping
            })
        });

        if (!response.ok) throw new Error("Network error");
        const result = await response.json();

        document.getElementById("result").innerHTML = `
            <h3>🌍 Your Estimated Carbon Footprint: ${result.footprint} kg CO₂</h3>
            <p>💡 AI Suggestion: ${result.suggestion}</p>
        `;
    } catch (error) {
        console.error("Error:", error);
        document.getElementById("result").innerHTML = "⚠️ Error connecting to server";
    }
});



