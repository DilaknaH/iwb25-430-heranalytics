import ballerina/time;
import ballerina/math;
import ballerina/log;
import ballerina/io;

// Utility functions for the Eco AI Agent

// Time utilities
public function getCurrentTimestamp() returns string {
    time:Utc now = time:utcNow();
    return time:utcToString(now);
}

public function formatTimestamp(time:Utc timestamp) returns string {
    return time:utcToString(timestamp);
}

public function getTimestampDaysAgo(int days) returns string {
    time:Utc now = time:utcNow();
    time:Utc past = time:utcAddDuration(now, {
        day: -days
    });
    return time:utcToString(past);
}

// ID generation utilities
public function generateDeviceId() returns string {
    string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return generateRandomString(chars, 8);
}

public function generateSessionId() returns string {
    string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return generateRandomString(chars, 16);
}

public function generateApiKey() returns string {
    string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";
    return generateRandomString(chars, 32);
}

function generateRandomString(string chars, int length) returns string {
    string result = "";
    int i = 0;
    while i < length {
        int randomIndex = math:randomInRange(0, chars.length() - 1);
        result += chars.substring(randomIndex, randomIndex + 1);
        i += 1;
    }
    return result;
}

// Math utilities
public function calculateAverage(float[] values) returns float {
    if values.length() == 0 {
        return 0.0;
    }
    
    float sum = 0.0;
    foreach var value in values {
        sum += value;
    }
    return sum / values.length();
}

public function calculateMax(float[] values) returns float {
    if values.length() == 0 {
        return 0.0;
    }
    
    float max = values[0];
    foreach var value in values {
        if value > max {
            max = value;
        }
    }
    return max;
}

public function calculateMin(float[] values) returns float {
    if values.length() == 0 {
        return 0.0;
    }
    
    float min = values[0];
    foreach var value in values {
        if value < min {
            min = value;
        }
    }
    return min;
}

public function calculateSum(float[] values) returns float {
    float sum = 0.0;
    foreach var value in values {
        sum += value;
    }
    return sum;
}

public function calculatePercentage(float part, float whole) returns float {
    if whole == 0.0 {
        return 0.0;
    }
    return (part / whole) * 100;
}

// Logging utilities
public function logInfo(string message) {
    log:printInfo("[INFO] " + message);
}

public function logError(string message, error? err = ()) {
    if err is error {
        log:printError("[ERROR] " + message + ": " + err.message());
    } else {
        log:printError("[ERROR] " + message);
    }
}

public function logWarning(string message) {
    log:printWarn("[WARN] " + message);
}

public function logDebug(string message) {
    log:printDebug("[DEBUG] " + message);
}

// File utilities
public function readFile(string filePath) returns string|error {
    return io:fileReadString(filePath);
}

public function writeFile(string filePath, string content) returns error? {
    return io:fileWriteString(filePath, content);
}

// String utilities
public function isNullOrEmpty(string? value) returns boolean {
    if value is () {
        return true;
    }
    return value == "";
}

public function truncateString(string value, int maxLength) returns string {
    if value.length() <= maxLength {
        return value;
    }
    return value.substring(0, maxLength) + "...";
}

// Array utilities
public function removeDuplicates(string[] arr) returns string[] {
    string[] result = [];
    foreach var item in arr {
        if !result.includes(item) {
            result.push(item);
        }
    }
    return result;
}

public function filterArray(string[] arr, function (string) returns boolean predicate) returns string[] {
    string[] result = [];
    foreach var item in arr {
        if predicate(item) {
            result.push(item);
        }
    }
    return result;
}