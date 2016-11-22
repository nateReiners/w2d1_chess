

class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self unless boss.nil?
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end



class Manager < Employee

  attr_reader :employees, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @employees = []
    super(name, title, salary, boss)
  end

  def find_sub_employee_salary_total
    # first = emps.shift
    # sum = self.find_sub_employee_salary_total(emps)
    # sum += sum.last + first
    # sum
    total = 0

    @employees.each do |employee|
      if employee.is_a?(Manager)
        total = employee.salary + employee.find_sub_employee_salary_total
      else
        total += employee.salary
      end
    end
    total
  end

  def bonus(multiplier)
    multiplier * self.find_sub_employee_salary_total
  end
  #
  # def add_employee(employee)
  #   @employees << employee
  #   employee.boss = self
  # end



end

ned = Manager.new("Ned", "Founder", 1_000_000, nil)
darren = Manager.new("Darren", "TA Manager", 78_000, ned)
shawna = Employee.new("shawna", "ta", 12_000, darren)
david = Employee.new("David", "ta", 10_000, darren)
#
# p ned.employees.map { |e| e.name }
# p ned.find_sub_employee_salary_total
# p darren.find_sub_employee_salary_total

p ned.bonus(5) # => 500_000

p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000
