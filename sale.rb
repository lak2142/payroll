class Sale
  attr_reader :amount

  def initialize(amount)
    @amount = amount.to_i
  end

  class << self

    def populate_sales
      sales_list = CSV.read('sales_data.csv', headers: true)
      sales_list.each do |row|
        Employee.find_employee(row["last_name"]).sales << Sale.new(row["gross_sale_value"])
        Employee.all_employees.select{|employee| employee.class == Owner}.each{|owner| owner.sales << Sale.new(row["gross_sale_value"])}
      end
    end

  end

end
