require 'rspotify'

class Spotify
  def self.album_search artist, title
    album = RSpotify::Album.search("#{artist} #{title}").first
    if album
      album.uri
    else
      puts "Unable to find a spotify album for: #{artist} #{title}"
      nil
    end
  end

  def self.album_url artist, title
    album = RSpotify::Album.search("#{artist} #{title}").first
    if album
      "https://open.spotify.com/album/#{album.id}"
    else
      puts "Unable to find a spotify album for: #{artist} #{title}"
      nil
    end
  end

  def self.track_search artist, title
    tracks = RSpotify::Track.search("#{artist} #{title}")
    if tracks.any?
      tracks[0].uri
    else
      puts "Unable to find a spotify track for: #{artist} #{title}"
      nil
    end
  end

  def self.authenticate!
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  end
end
