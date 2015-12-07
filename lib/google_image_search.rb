require 'uri'
require 'httparty'

class GoogleImageSearch
  BASE_URL = "https://www.googleapis.com/customsearch/v1"

  def self.search query
    @google_api_key = ENV['GOOGLE_API_KEY'].to_s

    raise ArgumentError.new("GOOGLE_API_KEY must be set in your ENV to search google") if @google_api_key.empty?

    options = {
      q: query,
      searchType: "image",
      cx: "009417781679318038892:yufe6eiwyeu", # a custom search engine id the searches for images across the web
      key: @google_api_key
    }
    response = HTTParty.get(BASE_URL, query: options)
    if response.code == 200
      images = JSON.parse(response.body)["items"].map { |i| i["link"] }[0...5]
      images.shuffle!
      while images.length > 0
        image = images.pop

        # make sure the image is live before we post it
        # TODO: Some sensible file-size and dimension checking would be nice
        image_response = HTTParty.get(image)
        if image_response.code == 200 && image_response.content_type.include?("image/")
          puts "Found image for '#{query}': #{image}"
          return image
        end
      end
    else
      puts "Unable to search Google: #{response}"
    end

    nil
  end
end
