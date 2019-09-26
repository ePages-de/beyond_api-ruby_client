# frozen_string_literal: true

BeyondAPI.setup do |config|
  # ==> Client configuration
  config.client_id = nil
  config.client_secret = nil

  # ==> API configuration
  # Configure the open connection timeout in seconds. Default is 2 seconds.
  # config.open_timeout = 2.seconds

  # Configure the request timeout in seconds. Default is 5 seconds.
  # config.timeout = 5.seconds

  # ==> Response configuration
  # Configure if :_links should be removed from response. Default is false and
  # :_links are gonna be part of the response.
  # config.remove_response_links = false

  # Configure if first character underescores should be removed on response hash
  # keys. For example, if set to true, :_id will become :id. Default is false.
  # config.remove_response_key_underscores = false

  # Configure if responses should be transformed to ObjectStructs. If set to
  # true, it gives you the posibility to access response data on a doted way.
  # With OpenStructs => response.embeded.products.first.id
  # Without OpenStructs => response["embeded"]["products"].first["id"]
  # config.object_struct_responses = false
end
