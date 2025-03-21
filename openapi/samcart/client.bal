// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [SamCart API v1.0.0](https://developer.samcart.com/) OpenAPI specification.
# SamCart's Public API is used for accessing the data inside your SamCart marketplace.
@display {label: "SamCart", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [SamCart account](https://www.samcart.com/) and obtain tokens following [this guide](https://developer.samcart.com/#section/Authentication).
    #
    # + apiKeyConfig - API keys for authorization 
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ApiKeysConfig apiKeyConfig, ConnectionConfig config =  {}, string serviceUrl = "https://api.samcart.com/v1") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        self.apiKeyConfig = apiKeyConfig.cloneReadOnly();
        return;
    }
    # Retrieve all charges
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more charges 
    remote isolated function getCharges(string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse200|error {
        string resourcePath = string `/charges`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse200 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a charge
    #
    # + id - The SamCart ID for the charge 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation 
    remote isolated function getByChargeId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns ChargeService|error {
        string resourcePath = string `/charges/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ChargeService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all refunds on a charge
    #
    # + id - The SamCart ID for the charge 
    # + return - Successful operation. Response will return an array of 0 or more refunds 
    remote isolated function getMultipleRefundsByChargeId(int id) returns RefundService[]|error {
        string resourcePath = string `/charges/${getEncodedUri(id)}/refunds`;
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        RefundService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a refund on a charge
    #
    # + id - The SamCart ID for the charge 
    # + refundId - The SamCart ID for the refund 
    # + return - Successful operation 
    remote isolated function getRefundByChargeId(int id, int refundId) returns RefundService|error {
        string resourcePath = string `/charges/${getEncodedUri(id)}/refunds/${getEncodedUri(refundId)}`;
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        RefundService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all customers
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more customers 
    remote isolated function getCustomers(string? createdAtMin = (), string? createdAtMax = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse2001|error {
        string resourcePath = string `/customers`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2001 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a customer
    #
    # + id - The SamCart ID for the customer 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + return - Successful operation 
    remote isolated function getByCustomerId(int id, string? createdAtMin = (), string? createdAtMax = ()) returns CustomerService|error {
        string resourcePath = string `/customers/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        CustomerService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all addresses for a customer
    #
    # + id - The SamCart ID for the customer 
    # + return - Successful operation. Response will return an array of 0 or more addresses 
    remote isolated function getAddressesByCustomerId(int id) returns AddressService[]|error {
        string resourcePath = string `/customers/${getEncodedUri(id)}/addresses`;
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        AddressService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all charges for a customer
    #
    # + id - The SamCart ID for the customer 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation. Response will return an array of 0 or more charges 
    remote isolated function getChargesByCustomerId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns ChargeService[]|error {
        string resourcePath = string `/customers/${getEncodedUri(id)}/charges`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ChargeService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all orders for a customer
    #
    # + id - The SamCart ID for the customer 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation. Response will return an array of 0 or more orders 
    remote isolated function getOrdersByCustomerId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns OrderService[]|error {
        string resourcePath = string `/customers/${getEncodedUri(id)}/orders`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        OrderService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all subscriptions for a customer
    #
    # + id - The SamCart ID for the customer 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + rebillingAtMin - Filter by UTC rebilling date at or after given date 
    # + rebillingAtMax - Filter by UTC rebilling date at or before given date 
    # + canceledAtMin - Filter by UTC canceled date at or after given date 
    # + canceledAtMax - Filter by UTC canceled date at or before given date 
    # + status - Filter subscriptions by status 
    # + 'type - Filter subscriptions by type 
    # + testMode - Filter by test mode 
    # + return - Successful operation. Response will return an array of 0 or more subscriptions 
    remote isolated function getSubscriptionsByCustomerId(int id, string? createdAtMin = (), string? createdAtMax = (), string? rebillingAtMin = (), string? rebillingAtMax = (), string? canceledAtMin = (), string? canceledAtMax = (), string? status = (), string? 'type = (), boolean? testMode = ()) returns SubscriptionService[]|error {
        string resourcePath = string `/customers/${getEncodedUri(id)}/subscriptions`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "rebilling_at_min": rebillingAtMin, "rebilling_at_max": rebillingAtMax, "canceled_at_min": canceledAtMin, "canceled_at_max": canceledAtMax, "status": status, "type": 'type, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SubscriptionService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all failed charges
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more failed charges 
    remote isolated function getFailedCharges(string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse2002|error {
        string resourcePath = string `/failed-charges`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2002 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a failed charge
    #
    # + id - The SamCart ID for the charge 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation 
    remote isolated function getByFailedChargeId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns FailedChargeService|error {
        string resourcePath = string `/failed-charges/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        FailedChargeService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all orders
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more orders 
    remote isolated function getOrders(string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse2003|error {
        string resourcePath = string `/orders`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2003 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve an order
    #
    # + id - The SamCart ID for the order 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation 
    remote isolated function getByOrderId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns OrderService|error {
        string resourcePath = string `/orders/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        OrderService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all charges on an order
    #
    # + id - The SamCart ID for the order 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation. Response will return an array of 0 or more charges 
    remote isolated function getChargesByOrderId(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns ChargeService[]|error {
        string resourcePath = string `/orders/${getEncodedUri(id)}/charges`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ChargeService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve customer on an order
    #
    # + id - The SamCart ID for the order 
    # + return - Successful operation 
    remote isolated function getCustomerByOrderId(int id) returns CustomerService|error {
        string resourcePath = string `/orders/${getEncodedUri(id)}/customer`;
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        CustomerService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all subscriptions on an order
    #
    # + id - The SamCart ID for the order 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + rebillingAtMin - Filter by UTC rebilling date at or after given date 
    # + rebillingAtMax - Filter by UTC rebilling date at or before given date 
    # + canceledAtMin - Filter by UTC canceled date at or after given date 
    # + canceledAtMax - Filter by UTC canceled date at or before given date 
    # + testMode - Filter by test mode 
    # + status - Filter subscriptions by status 
    # + 'type - Filter subscriptions by type 
    # + return - Successful operation. Response will return an array of 0 or more subscriptions 
    remote isolated function getSubscriptionsByOrderId(int id, string? createdAtMin = (), string? createdAtMax = (), string? rebillingAtMin = (), string? rebillingAtMax = (), string? canceledAtMin = (), string? canceledAtMax = (), boolean? testMode = (), string? status = (), string? 'type = ()) returns SubscriptionService[]|error {
        string resourcePath = string `/orders/${getEncodedUri(id)}/subscriptions`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "rebilling_at_min": rebillingAtMin, "rebilling_at_max": rebillingAtMax, "canceled_at_min": canceledAtMin, "canceled_at_max": canceledAtMax, "test_mode": testMode, "status": status, "type": 'type};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SubscriptionService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all products
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + status - Filter product by status 
    # + productCategory - Filter product by category 
    # + pricingType - Filter product by pricing type 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more products 
    remote isolated function getProducts(string? createdAtMin = (), string? createdAtMax = (), string? status = (), string? productCategory = (), string? pricingType = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse2004|error {
        string resourcePath = string `/products`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "status": status, "product_category": productCategory, "pricing_type": pricingType, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2004 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a product
    #
    # + id - The SamCart ID for the product 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + status - Filter product by status 
    # + productCategory - Filter product by category 
    # + pricingType - Filter product by pricing type 
    # + return - Successful operation 
    remote isolated function getByProductId(int id, string? createdAtMin = (), string? createdAtMax = (), string? status = (), string? productCategory = (), string? pricingType = ()) returns ProductService|error {
        string resourcePath = string `/products/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "status": status, "product_category": productCategory, "pricing_type": pricingType};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ProductService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve all subscriptions
    #
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + rebillingAtMin - Filter by UTC rebilling date at or after given date 
    # + rebillingAtMax - Filter by UTC rebilling date at or before given date 
    # + canceledAtMin - Filter by UTC canceled date at or after given date 
    # + canceledAtMax - Filter by UTC canceled date at or before given date 
    # + testMode - Filter by test mode 
    # + status - Filter subscriptions by status 
    # + 'type - Filter subscriptions by type 
    # + offset - The offset value used to paginate through a list of entries. If the dir query parameter is prev then the offset will be the id of the first record of the data set otherwise the offset will be the id of the last record 
    # + 'limit - An optional limit for the number of entries on a page with a maximum value of 100. Default value is 100 if not provided. 
    # + dir - The direction to paginate the next set of data. If dir is prev the page will return a data set before the offset otherwise the data set will be after the offset. Default value is next if not provided. 
    # + return - Successful operation. Response will return an array of 0 or more subscriptions 
    remote isolated function getSubscriptions(string? createdAtMin = (), string? createdAtMax = (), string? rebillingAtMin = (), string? rebillingAtMax = (), string? canceledAtMin = (), string? canceledAtMax = (), boolean? testMode = (), string? status = (), string? 'type = (), int? offset = (), int? 'limit = (), string? dir = ()) returns InlineResponse2005|error {
        string resourcePath = string `/subscriptions`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "rebilling_at_min": rebillingAtMin, "rebilling_at_max": rebillingAtMax, "canceled_at_min": canceledAtMin, "canceled_at_max": canceledAtMax, "test_mode": testMode, "status": status, "type": 'type, "offset": offset, "limit": 'limit, "dir": dir};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        InlineResponse2005 response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a subscription
    #
    # + id - The SamCart ID for the subscription 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + rebillingAtMin - Filter by UTC rebilling date at or after given date 
    # + rebillingAtMax - Filter by UTC rebilling date at or before given date 
    # + canceledAtMin - Filter by UTC canceled date at or after given date 
    # + canceledAtMax - Filter by UTC canceled date at or before given date 
    # + testMode - Filter by test mode 
    # + status - Filter subscriptions by status 
    # + 'type - Filter subscriptions by type 
    # + return - Successful operation 
    remote isolated function getSubscriptionById(int id, string? createdAtMin = (), string? createdAtMax = (), string? rebillingAtMin = (), string? rebillingAtMax = (), string? canceledAtMin = (), string? canceledAtMax = (), boolean? testMode = (), string? status = (), string? 'type = ()) returns SubscriptionService|error {
        string resourcePath = string `/subscriptions/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "rebilling_at_min": rebillingAtMin, "rebilling_at_max": rebillingAtMax, "canceled_at_min": canceledAtMin, "canceled_at_max": canceledAtMax, "test_mode": testMode, "status": status, "type": 'type};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SubscriptionService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve charges on a subscription
    #
    # + id - The SamCart ID for the subscription 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + testMode - Filter by test mode 
    # + return - Successful operation. Response will return an array of 0 or more charges 
    remote isolated function getChargesBySubscriptionID(int id, string? createdAtMin = (), string? createdAtMax = (), boolean? testMode = ()) returns ChargeService[]|error {
        string resourcePath = string `/subscriptions/${getEncodedUri(id)}/charges`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax, "test_mode": testMode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ChargeService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a customer on a subscription
    #
    # + id - The SamCart ID for the subscription 
    # + return - Successful operation 
    remote isolated function getCustomerBySubscriptionID(int id) returns CustomerService|error {
        string resourcePath = string `/subscriptions/${getEncodedUri(id)}/customer`;
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        CustomerService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a subscription's history
    #
    # + id - The SamCart ID for the subscription 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + return - Successful operation. Response will return an array of 0 or more history entries 
    remote isolated function getHistoriesBySubscriptionID(int id, string? createdAtMin = (), string? createdAtMax = ()) returns SubscriptionHistoryService[]|error {
        string resourcePath = string `/subscriptions/${getEncodedUri(id)}/history`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SubscriptionHistoryService[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a plan for a subscription
    #
    # + id - The SamCart ID for the subscription 
    # + createdAtMin - Filter by UTC created at date at or after given date 
    # + createdAtMax - Filter by UTC created at date at or before given date 
    # + return - Successful operation 
    remote isolated function getPlanBySubscriptionID(int id, string? createdAtMin = (), string? createdAtMax = ()) returns SubscriptionPlanService|error {
        string resourcePath = string `/subscriptions/${getEncodedUri(id)}/plan`;
        map<anydata> queryParam = {"created_at_min": createdAtMin, "created_at_max": createdAtMax};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"sc-api": self.apiKeyConfig.scApi};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        SubscriptionPlanService response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
}
