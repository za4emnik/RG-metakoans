class Module
  def attribute(name, &block)

    name, value = name.first if name.kind_of?(Hash)

    define_method "#{name}=" do |value|
      instance_variable_set(:"@#{name}", value)
    end

    define_method "#{name}" do
      unless self.send("#{name}?")
        self.send("#{name}=", block ? instance_eval(&block) : value)
      else
        instance_variable_get(:"@#{name}")
      end
    end

    define_method "#{name}?" do
      instance_variable_get(:"@#{name}") ? true : false
    end
  end
end
