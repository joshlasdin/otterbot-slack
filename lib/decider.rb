class Decider
  def self.decide query
    query = query.to_s.strip.gsub("?", "")
    return nil if query.empty?

    options = query.split(" or ")
    if options.one?
      # e.g. /shouldi go home?
      decision = ["you should", "you should NOT"].shuffle.shift
      "#{decision} #{options.shift}"
    else
      # e.g. /shouldi eat dinner or watch tv?
      "you should #{options.shuffle.shift}"
    end
  end
end
