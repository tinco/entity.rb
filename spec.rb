require './entity'
describe "Component Entity System" do
    describe "defining a simple system" do
        it "should give us a nice api" do
            Component.create(:physics, :position, :velocity, :weight)
            rock = Entity.create(:rock, :physics => {:position => [0,0], :velocity => 0, :weight => 0.5} )

            rock.physics.position.should == [0,0]
            rock.physics.weight.should == 0.5
        end
    end
end
