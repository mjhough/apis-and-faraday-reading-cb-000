class SearchesController < ApplicationController
  def search
  end

  def foursquare
  begin
    @resp = Faraday.get('https://api.foursquare.com/v2/venues/search') do |req|
      req.params['client_id'] = '1HLVIKFPPZV3TM00BHZHYUS5DV4GCBXXE35UWPX44T1E35OS'
      req.params['client_secret'] = 'MP3NYYZZM5GLXYQCB42V2UCWE5TS4UGIH4JVHPJZMBRKQB1D'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'cofee shop'
    end

    body_hash = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body_hash['response']['venues']
    else
      @error = body_hash['meta']['errorDetail']
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end

    render 'search'
  end
end
