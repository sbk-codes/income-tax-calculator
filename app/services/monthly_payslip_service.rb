# app/services/monthly_payslip_service.rb

class MonthlyPayslipService < ApplicationService
  def initialize(name, annual_salary)
    @name = name
    @annual_salary = annual_salary
  end

  def call
    {
      name: @name,
      gross_monthly_income: (monthly_salary * 12).round(2),
      monthly_income_tax: monthly_income_tax.round(2),
      net_monthly_income: net_monthly_income.round(2)
    }
  end

  private

  def monthly_salary
    @annual_salary / 12
  end

  def monthly_income_tax
    case @annual_salary
    when 0..20_000
      0
    when 20_001..40_000
      (@annual_salary - 20_000) * 0.1 / 12
    when 40_001..80_000
      (20_000 * 0.1 +
       (@annual_salary - 40_000) * 0.2) / 12
    when 80_001..180_000
      (20_000 * 0.1 +
       40_000 * 0.2 +
       (@annual_salary - 80_000) * 0.3) / 12
    else
      (20_000 * 0.1 +
       40_000 * 0.2 +
       100_000 * 0.3 +
       (@annual_salary - 180_000) * 0.4) / 12
    end
  end

  def net_monthly_income
    monthly_salary - monthly_income_tax
  end
end
