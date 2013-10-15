# LayerVault Ruby API Client

This is the Ruby client library that wraps the LayerVault API.

## Supported oAuth flows

Currently only [Resource Owner Credentials](https://github.com/applicake/doorkeeper/wiki/Using-Resource-Owner-Password-Credentials-flow) and [Client Credentials](https://github.com/applicake/doorkeeper/wiki/Client-Credentials-flow) are supported. Client credentials are pretty much useless as 99% of the API requires a User as context for the operations.

## Requesting an Access Token

1. Register or choose an application from https://layervault.com/oauth/applications/ and note the ```client_id``` and ```client_secret```.
2. Plug those values into:
```
curl -i https://layervault.com/oauth/token \
-F grant_type="password" \
-F username="" \
-F password="" \
-F client_id="<client_id_goes_here>" \
-F client_secret="<client_secret_goes_here>"
```
3. You now have an access token. You can make API requests by calling via CURL like so:

``` curl -H 'Authorization: Bearer <your access token>' 'https://layervault.com/api/v1/me' ```

## Access Tokens

Access Tokens are valid for two hours only. When you request a token, you are also told how long the token is valid for, in seconds, as part of the token response:

```
{"access_token":"aec9c670cf5e673bfedf83d055d2a2e0e5f37e52d3b41cffcf7874f73a7458bf","token_type":"bearer","expires_in":7200,"refresh_token":"afe9c670cf5e673bfedf83d055d2a2e0e5f37e52d3b41cffcf7874f73a7458bf","scope":"user"}
```

Here we can see that the Token is valid for 7200 more seconds, or two hours.

The API implements [Refresh Tokens](https://github.com/applicake/doorkeeper/wiki/Enable-Refresh-Token-Credentials) which allow you to request new tokens without re-authenticating the user through the Web credentials flow. You can see in the access token response above, a refresh_token was given for use in future calls. Store it, use it.

## Omniauth Strategy

We've made an [Omniauth Authentication Strategy](https://github.com/layervault/omniauth-layervault).

## Running the test suite.

```LAYERVAULT_API_ENDPOINT='https://layervault.com/api/v1/' LAYERVAULT_ACCESS_TOKEN=<your_access_token> be rspec spec/layervault/client ```

The test suite uses VCR to save making requests against the server.
