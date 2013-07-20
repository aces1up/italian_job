
class Class
  def subclasses
    result = []
    ObjectSpace.each_object(Class) { |klass| result << klass if klass < self }
    result
  end
end


module InheritedHelper

    def inherited( subclass )
        @herit ||= []
        puts "got subclass : #{subclass} #{self.obj_info}"
        @herit << subclass
    end

    def get_inherited()
        @herit ||= []
        @herit
    end
end

