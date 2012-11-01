class Entity
    attr_accessor :id

    def self.create(id, components)
        e = Entity.new(id)
        components.each do |component, fields|
            Component[component][e.id] = fields
        end
    end

    private
    def initialize(id)
        @id = id
    end
end

class Component
    attr_accessor :id, :fields

    def self.create(id, *fields, &block)
        register Component.new(id, fields, &block)
    end

    def self.[](id)
        @@components[id]
    end

    def []=(id, e)
        @entities[id] = e
    end

    def [](id)
        @entities[id]
    end

    def run
        @block[]
    end

    private
    def initialize(id, *fields, &block)
        @id = id
        @fields = fields
        @entities = {}
        @block = block
    end

    @@components ||= {}
    def self.register(component)
        @@components[component.id] = component
    end
end

Component.create(:physics, :position, :velocity, :weight)

rock = Entity.create(:rock, :physics => {:position => [0,0], :velocity => 0, :weight => 0.5} )

Component[:physics][:rock][:position] # 0,0
