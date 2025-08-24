import ballerina/http;
import ballerina/time;

// Helper function to extract decimal values from JSON
function extractDecimalValue(json data, string fieldName) returns decimal {
    if data is map<json> {
        json? value = data[fieldName];
        if value is decimal {
            return value;
        } else if value is int {
            return <decimal>value;
        } else if value is float {
            return <decimal>value;
        }
    }
    return 0.0d;
}

// Carbon footprint calculation function
function calculateCarbonFootprint(decimal electricity, decimal gas, decimal carTravel, 
                                 decimal flightDistance, decimal meatConsumption, decimal shopping) returns decimal {
    decimal electricityFactor = 0.43d;
    decimal gasFactor = 0.2d;
    decimal carFactor = 0.21d;
    decimal flightFactor = 0.18d;
    decimal meatFactor = 2.5d;
    decimal shoppingFactor = 0.1d;
    
    return (electricity * electricityFactor) +
           (gas * gasFactor) +
           (carTravel * carFactor) +
           (flightDistance * flightFactor) +
           (meatConsumption * meatFactor) +
           (shopping * shoppingFactor);
}

// Generate suggestions
function generateSuggestions(decimal carTravelVal, decimal electricityVal, 
                            decimal flightDistVal, decimal meatVal) returns string[] {
    string[] suggestions = [];
    
    if (carTravelVal > 100.0d) {
        suggestions.push("Use public transportation or carpooling");
    }
    if (electricityVal > 200.0d) {
        suggestions.push("Switch to energy-efficient appliances");
    }
    if (flightDistVal > 0.0d) {
        suggestions.push("Consider video conferencing instead of flights");
    }
    if (meatVal > 5.0d) {
        suggestions.push("Reduce meat consumption");
    }
    
    if (suggestions.length() == 0) {
        suggestions.push("Great job! Your carbon footprint is relatively low");
    }
    
    return suggestions;
}

// HTTP listener configuration
listener http:Listener ecoListener = new (9091);

// Main service
service / on ecoListener {
    
    resource function get root() returns string {
        return "✅ Eco AI Agent Running!";
    }
    
    resource function get health() returns json {
        return { 
            status: "healthy", 
            serviceName: "carbon-footprint",
            version: "1.0.0"
        };
    }

    resource function get test() returns json {
        return { 
            message: "Test endpoint working", 
            timestamp: time:utcNow().toString()
        };
    }

    // Carbon footprint calculation endpoint - FIXED: No hyphens in function name
    resource function post carbonFootprint(@http:Payload json data) returns json|error {
        decimal electricityVal = extractDecimalValue(data, "electricity");
        decimal gasVal = extractDecimalValue(data, "gas");
        decimal carTravelVal = extractDecimalValue(data, "carTravel");
        decimal flightDistVal = extractDecimalValue(data, "flights");
        decimal meatVal = extractDecimalValue(data, "meat");
        decimal shoppingVal = extractDecimalValue(data, "shopping");
        
        decimal carbonResult = calculateCarbonFootprint(electricityVal, gasVal, carTravelVal, flightDistVal, meatVal, shoppingVal);
        string[] suggestions = generateSuggestions(carTravelVal, electricityVal, flightDistVal, meatVal);
        
        return {
            success: true,
            carbonFootprint: carbonResult,
            unit: "kg CO₂",
            suggestions: suggestions,
            timestamp: time:utcNow().toString(),
            message: "Carbon footprint calculated successfully"
        };
    }

    // Emission factors endpoint - FIXED: No hyphens in function name
    resource function get emissionFactors() returns json {
        return {
            electricity: 0.43d,
            gas: 0.2d,
            carTravel: 0.21d,
            flights: 0.18d,
            meat: 2.5d,
            shopping: 0.1d,
            unit: "kg CO₂ per unit",
            timestamp: time:utcNow().toString(),
            note: "Standard emission factors for calculation"
        };
    }
}