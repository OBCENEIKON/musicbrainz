module MusicBrainz
  class Middleware < Faraday::Middleware
    def call(env)
      env[:request_headers]['Accept']     = 'application/json'
      env[:request_headers]['User-Agent'] = user_agent_string
      env[:request_headers]['Via']        = via_string
      @app.call(env)
    end

    def user_agent_string
      "#{config.app_name}/#{config.app_version} ( #{config.contact} )"
    end

    def via_string
      "gem musicbrainz/#{VERSION} (#{GH_PAGE_URL})"
    end

    def config
      MusicBrainz.config
    end
  end
end
