require 'spec_helper'

describe LayerVault::Response::Error do
  it "raises a BadRequest exception when the status is 400" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 400 }
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::BadRequest
  end

  it "raises a Unauthorized exception when the status is 401" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 401}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::Unauthorized
  end

  it "raises a Frobidden exception when the status is 403" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 403}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::Forbidden
  end

  it "raises a NotFound exception when the status is 404" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 404}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::NotFound
  end

  it "raises a NotAcceptable exception when the status is 406" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 406}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::NotAcceptable
  end

  it "raises a ClientError exception when the status is 407" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 407}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::ClientError
  end

  it "raises a InternalServerError exception when the status is 500" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 500}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::InternalServerError
  end

  it "raises a NotImplemented exception when the status is 501" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 501}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::NotImplemented
  end

  it "raises a BadGateway exception when the status is 502" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 502}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::BadGateway
  end

  it "raises a ServiceUnavailable exception when the status is 503" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 503}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::ServiceUnavailable
  end

  it "raises a ServiceError exception when the status is 504" do
    response = { method: :get, response_headers: { content_type: 'json' }, status: 504}
    ex = LayerVault::Response::Error.from_response(response)
    expect(ex).to be_instance_of LayerVault::Response::ServerError
  end
end