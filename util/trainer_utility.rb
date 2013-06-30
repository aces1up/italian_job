

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

