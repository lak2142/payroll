class CommissionSalesperson < Employee
  attr_accessor :sales

  def initialize(row)
    @sales = []
    @commission_percentage = row["commission_%"].to_f
    @total_sales = 0.0
    super(row)
  end

  def bonus_pay
    total_sales* @commission_percentage
  end

  def total_sales
    @total_sales
  end

end
