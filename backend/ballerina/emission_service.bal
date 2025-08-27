import ballerina/log;
import ballerina/sql;
import ballerinax/mysql; 
import ballerina/lang.'float;
import ballerina/lang.'string;

// Temporary validation functions

function validateEnergyConsumption(float consumption) returns boolean {
    return consumption >= 0.0 && consumption <= 10000.0;
}

function validateDeviceId(string deviceId) returns boolean {
    return deviceId.length() >= 8 && deviceId.length() <= 12;
}

function validateCarbonEmission(float emission) returns boolean {
    return emission >= 0.0 && emission <= 5000.0;
}
