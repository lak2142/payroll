class Owner < Employee
  attr_accessor :sales

  def initialize(row)
    super(row)
    @sales = []
    @total_sales = 0.0
  end

  def bonus_pay
    if @total_sales > 250000.0
      1000
    else
      0
    end
  end

end
