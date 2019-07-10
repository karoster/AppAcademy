class Employee
	attr_accessor :name, :title, :salary, :boss
	def initialize(name, title, salary, boss = nil)
		@name = name
		@title = title
		@salary = salary
		@boss = boss
	end

	def bonus(multiplier)
		@salary * multiplier
	end

end

class Manager < Employee

	def initialize(name, title, salary, boss = nil)
		@employees = []
		super
	end

	def add_employee(worker)
		@employees << worker
	end

	def bonus(multiplier)
		salaries = @employees.inject(0) do |mem, empl|
			mem += (empl.is_a?(Manager) ? empl.salary + empl.bonus(1) : empl.salary)
		end
		salaries * multiplier

	end

end

ned = Manager.new("Ned", "Founder", 1000000 )
darren = Manager.new("Darren", "TA Manager", 78000, "Ned")
ned.add_employee(darren)
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
david = Employee.new("David","TA",10000,"Darren")
darren.add_employee(david)
darren.add_employee(shawna)


puts ned.bonus(5)



