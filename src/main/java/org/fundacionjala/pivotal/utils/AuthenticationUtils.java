package org.fundacionjala.pivotal.utils;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.specification.RequestSpecification;
import org.fundacionjala.pivotal.config.PivotalEnvironment;

public final class AuthenticationUtils {

    private static final String TOKEN_HEADER = "X-TrackerToken";
    private static final PivotalEnvironment ENVIRONMENT = PivotalEnvironment.getInstance();
    private static AuthenticationUtils instance;
    private RequestSpecification requestSpecification;

    /**
     * Constructor for AuthenticationUtils.
     */
    private AuthenticationUtils() {
        initAPI();
    }

    /**
     * Getter to obtain the instance of class.
     * If Instance is null returns a new instance
     *
     * @return instance
     */
    public static AuthenticationUtils getInstance() {
        if (instance == null) {
            instance = new AuthenticationUtils();
        }
        return instance;
    }

    /**
     * Method to connect with the API of pivotal tracker using the
     * Token of user and the BaseUrl of API which is loaded
     * from properties file.
     */
    private void initAPI() {
        RestAssured.baseURI = PivotalEnvironment.getInstance().getBaseUrl();
        requestSpecification = new RequestSpecBuilder()
            .setRelaxedHTTPSValidation()
            .addHeader(TOKEN_HEADER, PivotalEnvironment.getInstance().getToken())
            .build();
    }

    /**
     * Getter to request specifications.
     *
     * @return requestSpecification
     */
    public RequestSpecification getLoggedReqSpec() {
       return requestSpecification;
    }
}
