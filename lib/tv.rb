require 'tv/version'

require 'yaml'
require 'faraday'

module TV

  class << self

    include RSpec::Matchers

    def play(file)
      raise "Could not find #{file}" unless File.exists?(file)
      interactions = YAML.load(File.read(file))['http_interactions']

      interactions.each do |interaction|
        request = interaction['request']
        response = interaction['response']

        connection = Faraday.new do |f|
          f.request  :url_encoded             # form-encode POST params
          f.response :logger                  # log requests to STDOUT
          f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        actual = connection.send(request['method'].to_sym) do |method|
          method.url       request['uri']
          method.body =    request['body']
          method.headers = request['headers']
        end

        match(response, actual)
      end
    end

    private

    def match(expected, actual)
      expected['headers'].each do |k, v|
        case k
        when 'Date'
        else
          this = [actual.headers[k]].flatten
          that = [v].flatten

          this.should(eq(that), "Header '#{k}' did not match.\n  Expected: #{that}\n       Got: #{this}")
        end
      end

      actual.body.should == expected['body']
    end

  end
end
