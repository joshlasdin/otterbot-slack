require 'rspotify'

class Spotify
  def self.album_search artist, title
    albums = RSpotify::Album.search("#{artist} #{title}")
    if albums.any?
      album[0].uri
    else
      puts "Unable to find a spotify albums for: #{artist} #{title}"
      nil
    end
  end

  def self.track_search artist, title
    albums = RSpotify::Track.search("#{artist} #{title}")
    if albums.any?
      album[0].uri
    else
      puts "Unable to find a spotify track for: #{artist} #{title}"
      nil
    end
  end

  def self.authenticate!
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end
end
