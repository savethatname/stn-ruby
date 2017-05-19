module Stn
  class Client
    BASE = "https://router.api.savethatname.com"

    def self.headers
      {
        "X-API-KEY" => Stn.configuration.api_key,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }
    end

    def self.endpoint(path)
      [BASE, Stn.configuration.api_version, path].join("/")
    end

    def post(path, params = {})
      HTTParty.post(Client.endpoint(path), headers: Client.headers, body: params)
    end

    def get(path, params = {})
      HTTParty.get(Client.endpoint(path), headers: Client.headers, query: params)
    end
  end
end