package org.fundacionjala.pivotal.context;

import org.fundacionjala.core.client.RequestManager;
import org.fundacionjala.pivotal.utils.AuthenticationUtils;

import java.util.HashMap;
import java.util.Map;

public class Context {
    private Map<String, String> requestData;
    private Map<String, String> data;
    /**
     * Constructor for the Context.
     */
    public Context() {
        this.requestData = new HashMap<>();
        this.data = new HashMap<>();
        RequestManager.setRequestSpec(AuthenticationUtils.getLoggedReqSpec());
    }

    /**
     * Saves the requestData of form data in requestData.
     *
     * @param requestDataToStore
     */
    public void saveRequestData(final Map<String, String> requestDataToStore) {
        this.requestData = requestDataToStore;
    }

    /**
     * Gets the value of key given.
     *
     * @param key
     * @return a String data
     */
    public String getRequestValue(final String key) {
        return this.requestData.getOrDefault(key, "");
    }

    /**
     * Saves the data of form data in data.
     *
     * @param key
     * @param value
     */
    public void saveData(final String key, final String value) {
        this.data.put(key, value);
    }

    /**
     * Gets the value of key given.
     *
     * @param key
     * @return a String data
     */
    public String getValueData(final String key) {
        return this.data.getOrDefault(key, "");
    }

    /**
     * Gets data map.
     *
     * @return data map
     */
    public Map<String, String> getData() {
        return data;
    }

    /**
     * Sets data map.
     *
     * @param dataToSet
     */
    public void setData(final Map<String, String> dataToSet) {
        this.data = dataToSet;
    }
}
