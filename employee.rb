require 'csv'
require 'pry'
require_relative 'sale.rb'
require_relative 'commission_sales_person.rb'
require_relative 'quota_sales_person.rb'
require_relative 'owner.rb'

class Employee
	attr_reader :name, :base_salary

	@@employees = []

	def initialize(row)
		@name = row["name"]
		@base_salary = row["base_salary"].to_f
	end

  def calculate_total_sales
    if !@sales.nil?
      @total_sales = 0
      @sales.each do |sale|
        @total_sales += sale.amount
      end
    end
  end

  def bonus_pay
    0
  end

  def gross_pay
    bonus_pay + base_salary / 12
  end

  def net_pay
    gross_pay * 0.7
  end

	class << self

		def populate_employees
			@employee_list = CSV.read('employees.csv', headers: true)
			@employee_list.each do |row|

				if row["job_description"] == "owner"
					@@employees << Owner.new(row)
				elsif row["job_description"] == "quota"
					@@employees << QuotaSalesperson.new(row)
				elsif row["job_description"] == "commission"
					@@employees << CommissionSalesperson.new(row)
				else
					@@employees << self.new(row)
				end

			end
		end

    def print_results
      self.all_employees.each do |employee|
        employee.calculate_total_sales
        puts "*********"
        puts "Name: #{employee.name}"
        puts "Monthly Base Pay: $#{("%.2f" % (employee.base_salary / 12))}"
        puts "Bonus Pay: $#{("%.2f" % employee.bonus_pay)}" if [QuotaSalesperson, Owner, CommissionSalesperson].include?(employee.class)
        puts "Gross Pay: $#{("%.2f" % employee.gross_pay)}"
        puts "Net Pay: $#{("%.2f" % employee.net_pay)}"
      end
    end

		def all_employees
			@@employees
		end

		def find_employee(name)
			self.all_employees.find do |employee|
				employee.name.split[1] == name
			end
		end

	end

end

Employee.populate_employees
Sale.populate_sales
Employee.print_results
