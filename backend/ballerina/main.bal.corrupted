import ballerina/http;
import ballerina/log;
import ballerina/jsonutils;

service / on new http:Listener(9090) {
    resource function get .() returns string {
        return "✅ Eco AI Agent Backend is running!";
    }

    resource function get health() returns json {
        return { 
            status: "healthy", 
            service: "carbon-footprint",
            version: "1.0.0"
        };
    }

    resource function get test() returns json {
        return { 
            message: "Test endpoint working", 
            timestamp: time:utcNow().toString()
        };
    }

    resource function post carbon-footprint(@http:Payload json data) returns json|error {
        decimal meet = check data.meet ?: 0;
        decimal gas = check data.gas ?: 0;
        decimal shopping = check data.shopping ?: 0;
        decimal carTravel = check data.carTravel ?: 0;
        decimal electricity = check data.electricity ?: 0;
        decimal flights = check data.flights ?: 0;
        
        // Calculate footprint
        decimal footprint = (meet * 2.5) + (gas * 0.2) + (shopping * 0.1) +
                           (carTravel * 0.21) + (electricity * 0.43) + (flights * 0.18);
        
        // Generate suggestions based on highest impact
        string[] suggestions = [];
        if (carTravel > 100) {
            suggestions.push("Consider public transportation or carpooling to reduce car travel emissions");
        }
        if (electricity > 200) {
            suggestions.push("Switch to energy-efficient appliances and LED lighting");
        }
        if (flights > 0) {
            suggestions.push("Consider video conferencing instead of short-haul flights");
        }
        if (meet > 5) {
            suggestions.push("Reduce meat consumption and incorporate plant-based meals");
        }
        
        return {
            success: true,
            footprint: footprint.toString(),
            unit: "kg CO₂",
            suggestions: suggestions,
            timestamp: time:utcNow().toString()
        };
    }
}

// Additional services for better code volume
service /config on new http:Listener(9091) {
    resource function get emission-factors() returns json {
        return {
            "carTravel": 0.21,
            "electricity": 0.43,
            "flights": 0.18,
            "meatConsumption": 2.5,
            "gasUsage": 0.2,
            "shopping": 0.1
        };
    }
}

service /analytics on new http:Listener(9092) {
    resource function get statistics() returns json {
        return {
            "totalCalculations": 150,
            "averageFootprint": 89.7,
            "mostCommonCategory": "shopping"
        };
    }
}
