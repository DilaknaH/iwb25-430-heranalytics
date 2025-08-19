import ballerina/http;
import ballerina/log;

service / on new http:Listener(9090) {
    resource function post calculate(http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        float carDistance = check payload.carDistance;
        float electricity = check payload.electricity;

        // Calculate CO₂ (simplified for now)
        float carCO2 = carDistance * 0.2; // 0.2 kg/km (example)
        float electricityCO2 = electricity * 0.5; // 0.5 kg/kWh (example)
        float totalCO2 = carCO2 + electricityCO2;

        // Generate AI suggestion (simplified)
        string suggestion = "Try biking 2 days/week to reduce CO₂ by " + (carCO2 * 0.3).toString() + " kg.";

        json response = {
            footprint: totalCO2,
            suggestion: suggestion
        };
        check caller->respond(response);
    }
}
