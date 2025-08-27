import ballerina/http;
import ballerina/jsonutils;
import ballerina/log;
import ballerina/config;
import ballerina/sql;
import ballerina/time;
import ballerina/math;

// Carbon API service for emission calculations and external API integration
public type CarbonEmission record {|
    float carbon_g;
    float carbon_lb;
    float carbon_kg;
    float carbon_mt;
    string estimated_at;
    string? country;
    string? state;
    string? electricity_unit;
    float? electricity_value;
    string? vehicle_model_id;
    string? distance_unit;
    float? distance_value;
    string? fuel_type;
    string? fuel_source_unit;
    float? fuel_source_value;
    string? methodology;
|};

public type EmissionEstimate record {|
    string type;
    CarbonEmission attributes;
|};

public type EmissionResponse record {|
    EmissionEstimate data;
|};

// Service for carbon emission calculations
service class CarbonAPIService {
    private final string apiKey;

    public function init() returns error? {
        self.apiKey = check config:getAsString("CARBON_API_KEY");
    }

    // Calculate vehicle emissions using external API
    public isolated function calculateVehicleEmissions(float distance, string distanceUnit, 
                                                     string vehicleModelId) returns CarbonEmission|error {
        json payload = {
            type: "vehicle",
            distance_unit: distanceUnit,
            distance_value: distance,
            vehicle_model_id: vehicleModelId
        };

        http:Client carbonApiClient = check new ("https://api.carboninterface.com/v1");
        http:Request request = new;
        request.setHeader("Authorization", "Bearer " + self.apiKey);
        request.setHeader("Content-Type", "application/json");
        request.setJsonPayload(payload);

        http:Response response = check carbonApiClient->post("/estimates", request);
        json responseJson = check response.getJsonPayload();
        EmissionResponse emissionResponse = check responseJson.fromJsonWithType(EmissionResponse);
        
        return emissionResponse.data.attributes;
    }

    // Calculate electricity emissions
    public isolated function calculateElectricityEmissions(float electricityValue, string electricityUnit, 
                                                         string country = "US") returns CarbonEmission|error {
        json payload = {
            type: "electricity",
            electricity_unit: electricityUnit,
            electricity_value: electricityValue,
            country: country
        };

        http:Client carbonApiClient = check new ("https://api.carboninterface.com/v1");
        http:Request request = new;
        request.setHeader("Authorization", "Bearer " + self.apiKey);
        request.setHeader("Content-Type", "application/json");
        request.setJsonPayload(payload);

        http:Response response = check carbonApiClient->post("/estimates", request);
        json responseJson = check response.getJsonPayload();
        EmissionResponse emissionResponse = check responseJson.fromJsonWithType(EmissionResponse);
        
        return emissionResponse.data.attributes;
    }

    // Calculate flight emissions
    public isolated function calculateFlightEmissions(string departureAirport, string destinationAirport,
                                                    int passengers = 1) returns CarbonEmission|error {
        json payload = {
            type: "flight",
            passengers: passengers,
            legs: [
                {
                    departure_airport: departureAirport,
                    destination_airport: destinationAirport
                }
            ]
        };

        http:Client carbonApiClient = check new ("https://api.carboninterface.com/v1");
        http:Request request = new;
        request.setHeader("Authorization", "Bearer " + self.apiKey);
        request.setHeader("Content-Type", "application/json");
        request.setJsonPayload(payload);

        http:Response response = check carbonApiClient->post("/estimates", request);
        json responseJson = check response.getJsonPayload();
        EmissionResponse emissionResponse = check responseJson.fromJsonWithType(EmissionResponse);
        
        return emissionResponse.data.attributes;
    }

    // Get available vehicle models
    public isolated function getVehicleModels() returns json|error {
        http:Client carbonApiClient = check new ("https://api.carboninterface.com/v1");
        http:Request request = new;
        request.setHeader("Authorization", "Bearer " + self.apiKey);

        http:Response response = check carbonApiClient->get("/vehicle_makes", request);
        return response.getJsonPayload();
    }

    // Fallback calculation if API is unavailable
    public isolated function calculateEmissionsFallback(string activityType, float value, 
                                                      string unit = "km") returns float {
        map<float> emissionFactors = {
            "car": 0.12,          // kg CO2 per km
            "bus": 0.05,
            "train": 0.03,
            "plane": 0.18,
            "electricity": 0.4,   // kg CO2 per kWh (US average)
            "natural_gas": 2.0,   // kg CO2 per therm
            "fuel_oil": 3.1       // kg CO2 per liter
        };

        float factor = emissionFactors[activityType] ?: 0.1;
        
        // Convert units if necessary
        if (unit == "miles") {
            value = value * 1.60934; // miles to km
        }
        
        return value * factor;
    }
}

// HTTP service for carbon API endpoints
service /carbon on new http:Listener(9092) {
    private final CarbonAPIService carbonService;

    function init() returns error? {
        self.carbonService = new ();
    }

    // POST /carbon/vehicle - Calculate vehicle emissions
    resource function post vehicle([@http:Payload] map<anydata> data) returns map<anydata>|http:Error {
        float distance = check data.getFloat("distance");
        string distanceUnit = data.getString("distance_unit") ?: "km";
        string vehicleModelId = check data.getString("vehicle_model_id");

        CarbonEmission|error result = self.carbonService->calculateVehicleEmissions(
            distance, distanceUnit, vehicleModelId
        );

        if result is error {
            log:printError("Carbon API call failed, using fallback", error = result);
            float fallback = self.carbonService->calculateEmissionsFallback(
                "car", distance, distanceUnit
            );
            return {
                carbon_kg: fallback,
                method: "fallback",
                timestamp: time:utcToString(time:utcNow()),
                warning: "External API unavailable, using estimated values"
            };
        }

        return {
            ...result,
            method: "carbon_interface_api",
            timestamp: time:utcToString(time:utcNow())
        };
    }

    // POST /carbon/electricity - Calculate electricity emissions
    resource function post electricity([@http:Payload] map<anydata> data) returns map<anydata>|http:Error {
        float electricityValue = check data.getFloat("electricity_value");
        string electricityUnit = data.getString("electricity_unit") ?: "kwh";
        string country = data.getString("country") ?: "US";

        CarbonEmission|error result = self.carbonService->calculateElectricityEmissions(
            electricityValue, electricityUnit, country
        );

        if result is error {
            log:printError("Carbon API call failed, using fallback", error = result);
            float fallback = self.carbonService->calculateEmissionsFallback(
                "electricity", electricityValue, electricityUnit
            );
            return {
                carbon_kg: fallback,
                method: "fallback",
                timestamp: time:utcToString(time:utcNow()),
                warning: "External API unavailable, using estimated values"
            };
        }

        return {
            ...result,
            method: "carbon_interface_api",
            timestamp: time:utcToString(time:utcNow())
        };
    }

    // POST /carbon/flight - Calculate flight emissions
    resource function post flight([@http:Payload] map<anydata> data) returns map<anydata>|http:Error {
        string departureAirport = check data.getString("departure_airport");
        string destinationAirport = check data.getString("destination_airport");
        int passengers = data.getInt("passengers") ?: 1;

        CarbonEmission|error result = self.carbonService->calculateFlightEmissions(
            departureAirport, destinationAirport, passengers
        );

        if result is error {
            return {error: "Flight emission calculation failed: " + result.message()};
        }

        return {
            ...result,
            method: "carbon_interface_api",
            timestamp: time:utcToString(time:utcNow())
        };
    }

    // GET /carbon/vehicles - Get available vehicle models
    resource function get vehicles() returns json|http:Error {
        json|error result = self.carbonService->getVehicleModels();
        
        if result is error {
            return {error: "Failed to fetch vehicle models: " + result.message()};
        }

        return result;
    }

    // GET /carbon/factors - Get emission factors
    resource function get factors() returns map<anydata> {
        return {
            car: 0.12,
            bus: 0.05,
            train: 0.03,
            plane: 0.18,
            bicycle: 0.0,
            walking: 0.0,
            electricity: 0.4,
            natural_gas: 2.0,
            fuel_oil: 3.1,
            unit: "kg CO2 per km or kWh",
            source: "EPA and industry averages",
            last_updated: time:utcToString(time:utcNow())
        };
    }
}
