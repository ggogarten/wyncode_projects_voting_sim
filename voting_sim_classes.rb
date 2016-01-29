# voting_sim_classes.rb

class Human
  include Enumerable
  attr_accessor :name
  def initialize (name)
    @name = name
  end
  @politicians_a = []
  @people_a = []
end

class Person < Human
  include Enumerable
  attr_accessor :politics
  def initialize (name, politics)
    @name = name
    @politics = politics
  end
end


class Politician < Human
  include Enumerable
	attr_accessor :p_party
	def initialize (name, p_party)
		@name = name
		@p_party = p_party
	end
end

#
# def test_person
# end

# test_polit
