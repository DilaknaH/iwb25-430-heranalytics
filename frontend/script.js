document.getElementById("carbonForm").addEventListener("submit", async (e) => {
    e.preventDefault();
    
    // Get values (ensure IDs match HTML)
    const carDistance = document.getElementById("carDistance").value;
    const electricity = document.getElementById("electricity").value; // Fixed typo
    
    try {
        const response = await fetch("http://localhost:9090/calculate", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ carDistance, electricity })
        });
        
        if (!response.ok) throw new Error("Network error");
        const result = await response.json();
        
        document.getElementById("result").innerHTML = `
            <h3>Your Carbon Footprint: ${result.footprint} kg CO₂</h3>
            <p>💡 AI Suggestion: ${result.suggestion}</p>
        `;
    } catch (error) {
        console.error("Error:", error);
        document.getElementById("result").innerHTML = "⚠️ Error connecting to server";
    }
});