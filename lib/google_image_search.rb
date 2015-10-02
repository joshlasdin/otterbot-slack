require 'uri'
require 'httparty'

class GoogleImageSearch
  # rsz = result size
  # safe = should safe search be enabled
  BASE_URL = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=5&safe=active&q="

  def self.search query
    response = HTTParty.get(BASE_URL + URI.encode(query))
    if response.code == 200
      images = JSON.parse(response.body)["responseData"]["results"].map { |i| i["url"] }
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
