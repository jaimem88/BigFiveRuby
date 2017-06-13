#!/usr/bin/ruby -w
require 'net/http'
require 'net/https'
require 'json'

class BigFiveResultsPoster
    attr_reader :results_hash, :email
    attr_reader :response_code,:token
    
    def initialize(results_hash, email)
        @results_hash = results_hash
        @email = email
    end

    def post
        uri = URI('https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions')
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path)
        req.add_field('Content-Type','application/json')

        self.results_hash['EMAIL']=self.email

        req.body = self.results_hash.to_json
      
        res = https.request(req)
        
        @response_code = res.code
        if res.code.to_i == 201 then
            @token = res.body
        else
            puts "response error: #{res.code} #{res.body}"
        end
        
    end
end

