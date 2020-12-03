package org.fundacionjala.pivotal.config;

import org.fundacionjala.core.config.Environment;

public class PivotalEnvironment extends Environment {
    /**
     * Initializes an instance of properties files.
     *
     * @param propertiesPath
     */
    public PivotalEnvironment(final String propertiesPath) {
        super(propertiesPath);
    }

    /**
     * get the token from the file.properties.
     *
     * @return token value.
     */
    public String getToken() {
        return getEnvProperty("token");
    }
}
