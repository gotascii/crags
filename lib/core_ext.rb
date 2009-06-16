class Object
 def to_os; self; end
end

class Array
 def to_os
   map {|i| i.to_os }
 end
end

class Hash
  def to_os
    _map = {}
    each {|k,v| _map[k] = v.to_os }
    OpenStruct.new(_map)
  end
end

module YAML
  def self.load_openstruct(source)
    self.load_file(source).to_os
  end
end