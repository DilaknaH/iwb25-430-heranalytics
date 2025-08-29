import ballerina/regex;
import ballerina/log;

// Validation functions for the Eco AI Agent

// Device validation
public function validateDeviceId(string deviceId) returns boolean {
    // Device ID should be alphanumeric and 8-12 characters long
    if deviceId.length() < 8 || deviceId.length() > 12 {
        logDebug("Device ID validation failed: Invalid length");
        return false;
    }
    
    // Check if it contains only alphanumeric characters
    boolean isValid = regex:matches(deviceId, "^[a-zA-Z0-9]+$");
    if !isValid {
        logDebug("Device ID validation failed: Contains invalid characters");
    }
    return isValid;
}

public function validateDeviceType(string deviceType) returns boolean {
    string[] validTypes = ["sensor", "meter", "controller", "monitor", "thermostat"];
    return validTypes.includes(deviceType.toLowerCase());
}

// Energy data validation
public function validateEnergyConsumption(float consumption) returns boolean {
    // Consumption should be positive and within reasonable limits
    if consumption < 0 || consumption > 10000 {
        logDebug("Energy consumption validation failed: Value out of range");
        return false;
    }
    return true;
}

public function validateLocation(string location) returns boolean {
    // Location should not be empty and should have reasonable length
    if location.length() == 0 || location.length() > 255 {
        logDebug("Location validation failed: Invalid length");
        return false;
    }
    return true;
}

public function validateTimestamp(string timestamp) returns boolean {
    // Basic timestamp validation (ISO 8601 format)
    return regex:matches(timestamp, "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?Z$");
}

// API input validation
public function validateEmail(string email) returns boolean {
    return regex:matches(email, "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
}

public function validateApiKey(string apiKey) returns boolean {
    // API key should be 32 characters long and contain valid characters
    if apiKey.length() != 32 {
        return false;
    }
    return regex:matches(apiKey, "^[a-zA-Z0-9-._~]+$");
}

public function validatePassword(string password) returns boolean {
    // Password should be at least 8 characters long
    // and contain at least one uppercase, one lowercase, one number, and one special character
    if password.length() < 8 {
        return false;
    }
    
    boolean hasUpper = regex:matches(password, "[A-Z]");
    boolean hasLower = regex:matches(password, "[a-z]");
    boolean hasDigit = regex:matches(password, "\\d");
    boolean hasSpecial = regex:matches(password, "[^a-zA-Z0-9]");
    
    return hasUpper && hasLower && hasDigit && hasSpecial;
}

// Configuration validation
public function validatePort(int port) returns boolean {
    return port >= 1 && port <= 65535;
}

public function validateHost(string host) returns boolean {
    // Validate hostname or IP address
    if host == "localhost" {
        return true;
    }
    
    // Check for IP address
    if regex:matches(host, "^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$") {
        string[] parts = host.split(".");
        foreach var part in parts {
            int num = checkpanic int:fromString(part);
            if num < 0 || num > 255 {
                return false;
            }
        }
        return true;
    }
    
    // Check for domain name
    return regex:matches(host, "^[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?)*$");
}

// Carbon emission validation
public function validateCarbonEmission(float emission) returns boolean {
    // Emission should be positive and within reasonable limits
    if emission < 0 || emission > 100000 {
        logDebug("Carbon emission validation failed: Value out of range");
        return false;
    }
    return true;
}

// Range validation
public function validateInRange(float value, float min, float max) returns boolean {
    return value >= min && value <= max;
}

public function validatePositive(float value) returns boolean {
    return value >= 0;
}

// JSON validation
public function validateJsonStructure(json data, string[] requiredFields) returns boolean {
    if data is () {
        return false;
    }
    
    foreach var field in requiredFields {
        if !data.hasKey(field) {
            logDebug("JSON validation failed: Missing required field '" + field + "'");
            return false;
        }
    }
    return true;
}

// Helper function for logging
function logDebug(string message) {
    log:printDebug("[VALIDATION] " + message);
}
=======
import ballerina/regex;
import ballerina/log;

// Validation functions for the Eco AI Agent

// Device validation
public function validateDeviceId(string deviceId) returns boolean {
    // Device ID should be alphanumeric and 8-12 characters long
    if deviceId.length() < 8 || deviceId.length() > 12 {
        logDebug("Device ID validation failed: Invalid length");
        return false;
    }
    
    // Check if it contains only alphanumeric characters
    boolean isValid = regex:matches(deviceId, "^[a-zA-Z0-9]+$");
    if !isValid {
        logDebug("Device ID validation failed: Contains invalid characters");
    }
    return isValid;
}

public function validateDeviceType(string deviceType) returns boolean {
    string[] validTypes = ["sensor", "meter", "controller", "monitor", "thermostat"];
    return validTypes.includes(deviceType.toLowerCase());
}

// Energy data validation
public function validateEnergyConsumption(float consumption) returns boolean {
    // Consumption should be positive and within reasonable limits
    if consumption < 0 || consumption > 10000 {
        logDebug("Energy consumption validation failed: Value out of range");
        return false;
    }
    return true;
}

public function validateLocation(string location) returns boolean {
    // Location should not be empty and should have reasonable length
    if location.length() == 0 || location.length() > 255 {
        logDebug("Location validation failed: Invalid length");
        return false;
    }
    return true;
}

public function validateTimestamp(string timestamp) returns boolean {
    // Basic timestamp validation (ISO 8601 format)
    return regex:matches(timestamp, "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?Z$");
}

// API input validation
public function validateEmail(string email) returns boolean {
    return regex:matches(email, "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
}

public function validateApiKey(string apiKey) returns boolean {
    // API key should be 32 characters long and contain valid characters
    if apiKey.length() != 32 {
        return false;
    }
    return regex:matches(apiKey, "^[a-zA-Z0-9-._~]+$");
}

public function validatePassword(string password) returns boolean {
    // Password should be at least 8 characters long
    // and contain at least one uppercase, one lowercase, one number, and one special character
    if password.length() < 8 {
        return false;
    }
    
    boolean hasUpper = regex:matches(password, "[A-Z]");
    boolean hasLower = regex:matches(password, "[a-z]");
    boolean hasDigit = regex:matches(password, "\\d");
    boolean hasSpecial = regex:matches(password, "[^a-zA-Z0-9]");
    
    return hasUpper && hasLower && hasDigit && hasSpecial;
}

// Configuration validation
public function validatePort(int port) returns boolean {
    return port >= 1 && port <= 65535;
}

public function validateHost(string host) returns boolean {
    // Validate hostname or IP address
    if host == "localhost" {
        return true;
    }
    
    // Check for IP address
    if regex:matches(host, "^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$") {
        string[] parts = host.split(".");
        foreach var part in parts {
            int num = checkpanic int:fromString(part);
            if num < 0 || num > 255 {
                return false;
            }
        }
        return true;
    }
    
    // Check for domain name
    return regex:matches(host, "^[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?)*$");
}

// Carbon emission validation
public function validateCarbonEmission(float emission) returns boolean {
    // Emission should be positive and within reasonable limits
    if emission < 0 || emission > 100000 {
        logDebug("Carbon emission validation failed: Value out of range");
        return false;
    }
    return true;
}

// Range validation
public function validateInRange(float value, float min, float max) returns boolean {
    return value >= min && value <= max;
}

public function validatePositive(float value) returns boolean {
    return value >= 0;
}

// JSON validation
public function validateJsonStructure(json data, string[] requiredFields) returns boolean {
    if data is () {
        return false;
    }
    
    foreach var field in requiredFields {
        if !data.hasKey(field) {
            logDebug("JSON validation failed: Missing required field '" + field + "'");
            return false;
        }
    }
    return true;
}

// Helper function for logging
function logDebug(string message) {
    log:printDebug("[VALIDATION] " + message);
}

