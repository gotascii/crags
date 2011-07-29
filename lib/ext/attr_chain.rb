module AttrChain
 def chained_attr_accessor(*names)
   names.each do |name|
     define_method :"#{name}" do | *args |
       return instance_variable_get(:"@#{name}") if args.length == 0
       if args.length == 1
           instance_variable_set(:"@#{name}", args[0])
           return self
       end
       raise ArgumentError.new("wrong number of arguments (#{args.length} for 1)")
     end
   end
 end
end