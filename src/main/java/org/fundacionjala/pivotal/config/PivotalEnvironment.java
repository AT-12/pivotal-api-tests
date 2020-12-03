package org.fundacionjala.pivotal.config;

import org.fundacionjala.core.config.Environment;

public final class PivotalEnvironment extends Environment {

    private static final String GRADLE_FILE = "gradle.properties";
    private static final String API_TOKEN = "token";
    private static PivotalEnvironment environment;
    /**
     * Initializes an instance of properties files.
     */
    private PivotalEnvironment() {
        super(GRADLE_FILE);
    }

    /**
     * Gets a singleton instance of the PivotalEnvironment.
     * @return PivotalEnvironment instance.
     */
    public static PivotalEnvironment getInstance() {
        if (environment == null) {
            environment = new PivotalEnvironment();
        }
        return environment;
    }

    /**
     * get the token from the file.properties.
     *
     * @return token value.
     */
    public String getToken() {
        return getEnvProperty(API_TOKEN);
    }
}
