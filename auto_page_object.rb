module CapybaraExtensions
  def data
    top_level.merge collections(self)
  end
  
  private
  
  def top_level
    matches = all('body > *')
    result = {}
    matches.each do |match|
      result.merge! data_attributes(match)
    end
    result
  end
  
  def collections(node)
    collection_nodes = node.all('*[@data-collection]')
    collections = {}
    collection_nodes.each do |collection_node|
      collection_name = collection_node['data-collection'].to_sym
      members = []
      node.all("*[data-collection='#{collection_name}'] > *").each do |child|
        members << data_attributes(child)
      end
      collections[collection_name] = members
    end
    collections
  end
  
end

def data_attributes(node)
  result = {}
  name = nil
  node.native.attributes.each_pair do |key, v|
    next unless key.start_with?('data-')
    next if key == 'data-collection'
    if key == 'data-name'
      name = node.text.strip
    else
      sym_key = key.gsub('data-', '').gsub('-', '_').to_sym
      if v.value != ""
        result[sym_key] = v.value
      else
        result[sym_key] = node.text
      end
    end
  end
  if name
    if result == {}
      name
    else
      {name => result}
    end
  else
    result
  end
end

# TODO not sure if including in both modules if the best approach
module Capybara
  module Node
    module Finders
      include CapybaraExtensions
    end
  end
end