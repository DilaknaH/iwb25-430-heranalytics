import ballerina/config;

// Configuration module for the Eco AI Agent
public type AppConfig record {|
    string host;
    int port;
    string dbUrl;
    string dbUser;
    string dbPassword;
    string openaiApiKey;
    int cacheSize;
    int cacheEvictionPolicy;
|};

// Get application configuration
public function getConfig() returns AppConfig {
    return {
        host: config:getAsString("HOST") ?? "localhost",
        port: config:getAsInt("PORT") ?? 8080,
        dbUrl: config:getAsString("DB_URL") ?? "jdbc:mysql://localhost:3306/eco_ai_db",
        dbUser: config:getAsString("DB_USER") ?? "root",
        dbPassword: config:getAsString("DB_PASSWORD") ?? "",
        openaiApiKey: config:getAsString("OPENAI_API_KEY") ?? "",
        cacheSize: config:getAsInt("CACHE_SIZE") ?? 1000,
        cacheEvictionPolicy: config:getAsInt("CACHE_EVICTION_POLICY") ?? 1
    };
}

// Validate configuration
public function validateConfig(AppConfig config) returns boolean {
    if config.port < 1 || config.port > 65535 {
        return false;
    }
    
    if config.dbUrl == "" {
        return false;
    }
    
    return true;
}