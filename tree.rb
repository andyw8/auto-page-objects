require 'nokogiri'

html = <<END
<span data-age="50" data-location="London" class="highlight">Joe Bloggs</span>

<span data-age="70" data-location="London" class="highlight">John Smith</span>
END

#doc = Nokogiri(html)

matches = Nokogiri(html).css('span:regex_attrs("^data-.*")', Class.new {
  def regex_attrs node_set, regex
    node_set.find_all { |node| node.attributes.keys.any? {|k| k =~ /#{regex}/ } }
  end
}.new)

matches.each do |match|
  p match
  puts
end