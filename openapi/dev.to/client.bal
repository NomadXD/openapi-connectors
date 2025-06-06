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

# This is a generated connector for [DEV API v0.9.7](https://developers.forem.com/api/) OpenAPI specification.
# Access Forem articles, users and other resources via API.
# For a real-world example of Forem in action, check out [DEV](https://www.dev.to).
# All endpoints that don't require authentication are CORS enabled.
# Dates and date times, unless otherwise specified, must be inthe [RFC 3339](https://tools.ietf.org/html/rfc3339) format.
@display {label: "dev.to", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create an [DEVto Account](https://dev.to/settings/account)  and obtain tokens by log into [DEV Account](https://www.interzoid.com/account).
    #
    # + apiKeyConfig - API keys for authorization 
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ApiKeysConfig apiKeyConfig, ConnectionConfig config =  {}, string serviceUrl = "https://dev.to/api") returns error? {
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
    # Published articles
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + tag - Using this parameter will retrieve articles that contain the requested tag. Articles will be ordered by descending popularity. This parameter can be used in conjuction with `top`. 
    # + tags - Using this parameter will retrieve articles with any of the comma-separated tags. Articles will be ordered by descending popularity. 
    # + tagsExclude - Using this parameter will retrieve articles that do _not_ contain _any_ of comma-separated tags. Articles will be ordered by descending popularity. 
    # + username - Using this parameter will retrieve articles belonging to a User or Organization ordered by descending publication date. If `state=all` the number of items returned will be `1000` instead of the default `30`. This parameter can be used in conjuction with `state`. 
    # + state - Using this parameter will allow the client to check which articles are fresh or rising. If `state=fresh` the server will return fresh articles. If `state=rising` the server will return rising articles. This param can be used in conjuction with `username`, only if set to `all`. 
    # + top - Using this parameter will allow the client to return the most popular articles in the last `N` days. `top` indicates the number of days since publication of the articles returned. This param can be used in conjuction with `tag`. 
    # + collectionId - Adding this will allow the client to return the list of articles belonging to the requested collection, ordered by ascending publication date. 
    # + return - A list of articles 
    remote isolated function getArticles(int page = 1, int perPage = 30, string? tag = (), string? tags = (), string? tagsExclude = (), string? username = (), string? state = (), int? top = (), int? collectionId = ()) returns ArticleIndex[]|error {
        string resourcePath = string `/articles`;
        map<anydata> queryParam = {"page": page, "per_page": perPage, "tag": tag, "tags": tags, "tags_exclude": tagsExclude, "username": username, "state": state, "top": top, "collection_id": collectionId};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArticleIndex[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new article
    #
    # + payload - Article to create 
    # + return - A newly created article 
    remote isolated function createArticle(ArticleCreate payload) returns ArticleShow|error {
        string resourcePath = string `/articles`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ArticleShow response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Published articles sorted by publish date
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of articles sorted by descending publish date 
    remote isolated function getLatestArticles(int page = 1, int perPage = 30) returns ArticleIndex[]|error {
        string resourcePath = string `/articles/latest`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArticleIndex[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User's articles
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of published articles 
    remote isolated function getUserArticles(int page = 1, int perPage = 30) returns ArticleMe[]|error {
        string resourcePath = string `/articles/me`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ArticleMe[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # User's all articles
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of articles 
    remote isolated function getUserAllArticles(int page = 1, int perPage = 30) returns ArticleMe[]|error {
        string resourcePath = string `/articles/me/all`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ArticleMe[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # User's published articles
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of published articles 
    remote isolated function getUserPublishedArticles(int page = 1, int perPage = 30) returns ArticleMe[]|error {
        string resourcePath = string `/articles/me/published`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ArticleMe[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # User's unpublished articles
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of articles 
    remote isolated function getUserUnpublishedArticles(int page = 1, int perPage = 30) returns ArticleMe[]|error {
        string resourcePath = string `/articles/me/unpublished`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ArticleMe[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # A published article by ID
    #
    # + id - Id of the article 
    # + return - An article 
    remote isolated function getArticleById(int id) returns ArticleShow|error {
        string resourcePath = string `/articles/${getEncodedUri(id)}`;
        ArticleShow response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an article
    #
    # + id - Id of the article 
    # + payload - Article params for the update. 
    # + return - The updated article 
    remote isolated function updateArticle(int id, ArticleUpdate payload) returns ArticleShow|error {
        string resourcePath = string `/articles/${getEncodedUri(id)}`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ArticleShow response = check self.clientEp->put(resourcePath, request, httpHeaders);
        return response;
    }
    # A published article by path
    #
    # + username - User or organization username. 
    # + slug - Slug of the article. 
    # + return - An article 
    remote isolated function getArticleByPath(string username, string slug) returns ArticleShow|error {
        string resourcePath = string `/articles/${getEncodedUri(username)}/${getEncodedUri(slug)}`;
        ArticleShow response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Comments
    #
    # + aId - Article identifier. 
    # + pId - Podcast Episode identifier. 
    # + return - A list of threads of comments 
    remote isolated function getCommentsByArticleId(int? aId = (), int? pId = ()) returns Comment[]|error {
        string resourcePath = string `/comments`;
        map<anydata> queryParam = {"a_id": aId, "p_id": pId};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Comment[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Comment
    #
    # + id - Comment identifier. 
    # + return - A comment and its descendants 
    remote isolated function getCommentById(string id) returns Comment|error {
        string resourcePath = string `/comments/${getEncodedUri(id)}`;
        Comment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Followers
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + sort - Specifies the sort order for the `created_at` param of the follow relationship. To sort by newest followers first (descending order) specify `?sort=-created_at`. 
    # + return - A list of followers 
    remote isolated function getFollowers(int page = 1, int perPage = 80, string sort = "created_at") returns Follower[]|error {
        string resourcePath = string `/followers/users`;
        map<anydata> queryParam = {"page": page, "per_page": perPage, "sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Follower[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Followed tags
    #
    # + return - A list of followed tags 
    remote isolated function getFollowedTags() returns FollowedTag[]|error {
        string resourcePath = string `/follows/tags`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        FollowedTag[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Published listings
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + category - Using this parameter will return listings belonging to the requested category. 
    # + return - A list of listings 
    remote isolated function getListings(int page = 1, int perPage = 30, string? category = ()) returns Listing[]|error {
        string resourcePath = string `/listings`;
        map<anydata> queryParam = {"page": page, "per_page": perPage, "category": category};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Listing[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new listing
    #
    # + payload - Listing to create 
    # + return - A newly created Listing 
    remote isolated function createListing(ListingCreate payload) returns Listing|error {
        string resourcePath = string `/listings`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Listing response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Published listings by category
    #
    # + category - The category of the listing 
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of listings 
    remote isolated function getListingsByCategory(ListingCategory category, int page = 1, int perPage = 30) returns Listing[]|error {
        string resourcePath = string `/listings/category/${getEncodedUri(category)}`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Listing[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # A listing
    #
    # + id - Id of the listing 
    # + return - A listing 
    remote isolated function getListingById(int id) returns Listing|error {
        string resourcePath = string `/listings/${getEncodedUri(id)}`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Listing response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Update a listing
    #
    # + id - Id of the listing 
    # + payload - Listing params for the update. 
    # + return - The updated article 
    remote isolated function updateListing(int id, ListingUpdate payload) returns ArticleShow|error {
        string resourcePath = string `/listings/${getEncodedUri(id)}`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ArticleShow response = check self.clientEp->put(resourcePath, request, httpHeaders);
        return response;
    }
    # An organization
    #
    # + username - Username of the organization 
    # + return - An organization 
    remote isolated function getOrganization(string username) returns Organization|error {
        string resourcePath = string `/organizations/${getEncodedUri(username)}`;
        Organization response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Organization's Articles
    #
    # + username - Username of the organization 
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of users belonging to the organization 
    remote isolated function getOrgArticles(string username, int page = 1, int perPage = 30) returns ArticleIndex[]|error {
        string resourcePath = string `/organizations/${getEncodedUri(username)}/articles`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArticleIndex[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Organization's listings
    #
    # + username - Username of the organization 
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + category - Using this parameter will return listings belonging to the requested category. 
    # + return - A list of listings belonging to the organization 
    remote isolated function getOrgListings(string username, int page = 1, int perPage = 30, string? category = ()) returns json[]|error {
        string resourcePath = string `/organizations/${getEncodedUri(username)}/listings`;
        map<anydata> queryParam = {"page": page, "per_page": perPage, "category": category};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Organization's users
    #
    # + username - Username of the organization 
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of users belonging to the organization 
    remote isolated function getOrgUsers(string username, int page = 1, int perPage = 30) returns User[]|error {
        string resourcePath = string `/organizations/${getEncodedUri(username)}/users`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        User[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Published podcast episodes
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + username - Using this parameter will retrieve episodes belonging to a specific podcast. 
    # + return - A list of podcast episodes 
    remote isolated function getPodcastEpisodes(int page = 1, int perPage = 30, string? username = ()) returns PodcastEpisode[]|error {
        string resourcePath = string `/podcast_episodes`;
        map<anydata> queryParam = {"page": page, "per_page": perPage, "username": username};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PodcastEpisode[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User or organization profile picture
    #
    # + username - Username of the user or organization 
    # + return - The profile image 
    remote isolated function getProfileImage(string username) returns ProfileImage|error {
        string resourcePath = string `/profile_images/${getEncodedUri(username)}`;
        ProfileImage response = check self.clientEp->get(resourcePath);
        return response;
    }
    # User's reading list
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - The reading list with a overwiew of the article 
    remote isolated function getReadinglist(int page = 1, int perPage = 30) returns ReadingList[]|error {
        string resourcePath = string `/readinglist`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        ReadingList[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Tags
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of tags 
    remote isolated function getTags(int page = 1, int perPage = 10) returns Tag[]|error {
        string resourcePath = string `/tags`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        Tag[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # The authenticated user
    #
    # + return - A user 
    remote isolated function getUserMe() returns User|error {
        string resourcePath = string `/users/me`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # A user
    #
    # + id - Id of the user. It can be either of the following two values:   - an integer representing the id of the user   - the string `by_username` (needs to be used in conjuction with the param `url`) 
    # + url - Username of the user 
    # + return - A user 
    remote isolated function getUser(string id, string? url = ()) returns User|error {
        string resourcePath = string `/users/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"url": url};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        User response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Articles with a video
    #
    # + page - Pagination page. 
    # + perPage - Page size (the number of items to return per page). 
    # + return - A list of video articles 
    remote isolated function getArticlesWithVideo(int page = 1, int perPage = 24) returns ArticleVideo[]|error {
        string resourcePath = string `/videos`;
        map<anydata> queryParam = {"page": page, "per_page": perPage};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ArticleVideo[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Webhooks
    #
    # + return - A list of webhooks 
    remote isolated function getWebhooks() returns WebhookIndex[]|error {
        string resourcePath = string `/webhooks`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        WebhookIndex[] response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create a new webhook
    #
    # + payload - Webhook to create 
    # + return - A newly created webhook 
    remote isolated function createWebhook(WebhookCreate payload) returns WebhookShow|error {
        string resourcePath = string `/webhooks`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        WebhookShow response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # A webhook endpoint
    #
    # + id - Id of the webhook 
    # + return - A webhook endpoint 
    remote isolated function getWebhookById(int id) returns WebhookShow|error {
        string resourcePath = string `/webhooks/${getEncodedUri(id)}`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        WebhookShow response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # A webhook endpoint
    #
    # + id - Id of the webhook 
    # + return - A successful deletion 
    remote isolated function deleteWebhook(int id) returns http:Response|error {
        string resourcePath = string `/webhooks/${getEncodedUri(id)}`;
        map<any> headerValues = {"api-key": self.apiKeyConfig.apiKey};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Response response = check self.clientEp->delete(resourcePath, headers = httpHeaders);
        return response;
    }
}
