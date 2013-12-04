class QuotaSalesperson < Employee
  attr_accessor :sales
  def initialize(row)
    @quota = row["quota"].to_f
    @quota_bonus = row["quota_bonus"].to_f
    @sales = []
    @total_sales = 0.0
    super(row)
  end

  def bonus_pay
    if @total_sales >= @quota
      @quota_bonus
    else
      0
    end
  end
end
