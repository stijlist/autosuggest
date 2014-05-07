require 'colorize'

class Autosuggest
  def self.suggest(string, set, coloropts={})
    res = set.detect {|completion| completion.match string } || string
    res = res.gsub(/^#{string}/, "")
    if coloropts.empty?
      string << res
    else
      res = res.colorize(coloropts[:completion]) unless coloropts.empty?
      string.colorize(coloropts[:input]) << res
    end
  end
end
