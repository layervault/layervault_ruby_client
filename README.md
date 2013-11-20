# LayerVault Ruby API Client

This is the Ruby client library that wraps the [LayerVault API](https://github.com/layervault/api). It assumes you have used another oAuth 2 library to obtain and manage a valid access token.

## Installation

Put this in your Gemfile and smoke it:

```ruby
gem 'layervault'
```

Or install it:

```shell
$ gem install layervault
```

## Supported oAuth flows

Currently only [Resource Owner Credentials](https://github.com/applicake/doorkeeper/wiki/Using-Resource-Owner-Password-Credentials-flow) and [Client Credentials](https://github.com/applicake/doorkeeper/wiki/Client-Credentials-flow) are supported. Client credentials are pretty much useless as 99% of the API requires a User as context for the operations.

## Requesting an Access Token

1. Register or choose an application from https://layervault.com/oauth/applications/ and note the `client_id` and `client_secret`.
2. Plug those values into the following curl snippet, including your LayerVault username and password:

```
curl -i https://api.layervault.com/oauth/token \
  -F grant_type="password" \
  -F username="<username_goes_here>" \
  -F password="<password_goes_here>" \
  -F client_id="<client_id_goes_here>" \
  -F client_secret="<client_secret_goes_here>"
```
3. You now have an access token. You can make API requests by calling via CURL like so:

```
curl -H 'Authorization: Bearer <your access token>' \
  'https://api.layervault.com/api/v1/me'
```

## Initializing the Client

You can initialize the client via Environment Variables or by passing configurations options into the client when you create it, like this:

``` ruby
@client = LayerVault::Client.new({
  access_token: 'your_access_token',
  api_endpoint: 'your_api_endpoint'
})
```

Or you can also say:

``` ruby
LayerVault.client.access_token = 'access_token'
LayerVault.client.api_endpoint = 'api_endpoint'
```

### Environment Variables

``` ruby
# You LayerVault API access token
ENV['LAYERVAULT_ACCESS_TOKEN']

# The API Endpoint you wish to target calls against (defaults to https://api.layervault.com/api/v1/)
ENV['LAYERVAULT_API_ENDPOINT']

# Defaults to LayerVault Ruby Gem #{LayerVault::VERSION}
ENV['LAYERVAULT_USER_AGENT']
```

### The User Agent

You should set the User agent to include your email address so that in the event your client does something wrong we can contact you.

## Making API calls

You can use the `LayerVault.client.<api_operation>` methods to call the API to perform actions. Alternatively, each API object has simple object model that allows you to say:

``` ruby
LayerVault.client.access_token = 'access_token'
p = LayerVault::Organization.for('layervault')
p.create_project('my new project')
```

And so on.

### Simple Object Model

There's a very simple object model provided by classes that implement [Hashie](https://github.com/intridea/hashie) objects that wrap the JSON responses from the ```LayerVault.client``` interface. The objects mostly all follow a ```.for``` pattern that accepts the appropriate number of arguments for the level of nesting the object represents. For example,

  - Organizations require the permalink of the organization: ```Organization.for('layervault')```
  - Projects require the permalink of the organization and the project name: ```Project.for('layervault', 'Designer News')```
  - ... and so on ...

#### Associations

When using the simple object model, associations will be hydrated into the correct child objects for the immediate child relationships only, allowing a simple level of traversal down the object model hierarchy. There is no lazy loding support that will automatically hydrated any deeper associations - you must perform new queries.

## Access Tokens

Access Tokens are valid for two hours only. When you request a token, you are also told how long the token is valid for, in seconds, as part of the token response:

``` json
{
  "access_token": "aec9c670cf5e673bfedf83d055d2a2e0e5f37e52d3b41cffcf7874f73a7458bf",
  "token_type": "bearer",
  "expires_in": 7200,
  "refresh_token": "afe9c670cf5e673bfedf83d055d2a2e0e5f37e52d3b41cffcf7874f73a7458bf",
  "scope": "user"
}
```

Here we can see that the Token is valid for 7200 more seconds, or two hours.

The API implements [Refresh Tokens](https://github.com/applicake/doorkeeper/wiki/Enable-Refresh-Token-Credentials) which allow you to request new tokens without re-authenticating the user through the Web credentials flow. You can see in the access token response above, a refresh_token was given for use in future calls. Store it, use it.

## Omniauth Strategy

If you're looking for something that makes a Rails integration more easy, we've made an [Omniauth Authentication Strategy](https://github.com/layervault/omniauth-layervault).

## Running the test suite.

You should create a test project called ```api-playground``` in your Organization. and make sure ```TEST_ORG``` and ```TEST_PROJECT``` environment variables are set correctly in the call below:

```TEST_ORG='layervault-test' TEST_PROJECT='api-playground' LAYERVAULT_API_ENDPOINT='https://api.layervault.com/api/v1/' LAYERVAULT_ACCESS_TOKEN=<your_access_token> be rspec spec/layervault/client ```

The test suite uses VCR to save making requests against the server. You always have the option of deleting the contents of the ```spec/cassettes``` folder to make real calls against the LayerVault servers.

## Client Methods Summary

### General
  - LayerVault.client.me

### Organizations

  - LayerVault.client.organization( organization_permalink )

### Projects
  - LayerVault.client.project( organization_permalink, project )
  - LayerVault.client.create_project( organization_permalink, project )
  - LayerVault.client.delete_project( organization_permalink, project )
  - LayerVault.client.move_project( organization_permalink, project, to )
  - LayerVault.client.change_project_folder_color( organization_permalink, project, color )

### Folders
  - LayerVault.client.folder( organization_permalink, project, folder_path )
  - LayerVault.client.create_folder( organization_permalink, project, folder_path )
  - LayerVault.client.delete_folder( organization_permalink, project, folder_path )
  - LayerVault.client.move_folder( organization_permalink, project, folder_path, new_folder )
  - LayerVault.client.change_folder_color( organization_permalink, project, folder_path, color )

### Files
  - LayerVault.client.file( organization_permalink, project, folder_path, file_name )
  - LayerVault.client.create_file( organization_permalink, project, folder_path, file_name, options )
  - LayerVault.client.delete_file( organization_permalink, project, folder_path, file_name )
  - LayerVault.client.move_file( organization_permalink, project, folder_path, new_folder, new_filename )
  - LayerVault.client.sync_check( organization_permalink, project, folder_path, options )

### Revisions
  - LayerVault.client.revision( organization_permalink, project, folder_path, file_name, revision )
  - LayerVault.client.previews( organization_permalink, project, folder_path, file_name, revision, options )
  - LayerVault.client.revisions( organization_permalink, project, folder_path, file_name, revision, options )
  - LayerVault.client.meta( organization_permalink, project, folder_path, file_name, revision )

