class Entity
    attr_accessor :id

    def self.create(id, components)
        e = Entity.new(id)
        components.each do |component, fields|
            Component[component][e.id] = fields
        end
        e
    end

    def method_missing(name, *args)
        super(name,*args) if args != []
        Component[name][id]
    end

    def ==(other)
        other.is_a? Entity && other.id == id
    end

    private
    def initialize(id = object_id)
        @id = id
    end
end

class Component
    attr_accessor :id, :fields

    def self.create(id, *fields)
        register Component.new(id, *fields)
    end

    def self.[](id)
        @@components[id]
    end

    def []=(id, fields)
        @entities[id] = fields if fields.is_a? @struct
        @entities[id] = @struct.new(*fields.values_at(*@fields))
    end

    def [](id)
        @entities[id]
    end

    private
    def initialize(id, *fields)
        @id = id
        @fields = fields
        @entities = {}
        @struct = Struct.new *fields
    end

    @@components ||= {}
    def self.register(component)
        @@components[component.id] = component
    end
end
