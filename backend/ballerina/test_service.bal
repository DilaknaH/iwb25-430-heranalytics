import ballerina/http;
import ballerina/io;

// Simple service with multiple endpoints
service / on new http:Listener(9090) {
    resource function get .() returns string {
        return "Root endpoint is working!";
    }
    
    resource function get health() returns string {
        return "Health endpoint is working!";
    }
    
    resource function get test() returns string {
        return "Test endpoint is working!";
    }
}

public function main() {
    io:println("?? Test service started on port 9090");
    io:println("Available endpoints:");
    io:println("  http://localhost:9090/");
    io:println("  http://localhost:9090/health");
    io:println("  http://localhost:9090/test");
}
