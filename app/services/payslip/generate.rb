module Payslip
  class Generate < ApplicationService
    def initialize(name, annual_salary)
      @name = name
      @annual_salary = annual_salary
    end

    def call
      generate_monthly_payslip
    end

    def generate_monthly_payslip
      gross_monthly_income = @annual_salary / 12.0
      monthly_income_tax = TaxCalculator::Calculate.call(@annual_salary) / 12.0
      net_monthly_income = gross_monthly_income - monthly_income_tax

      {
        employee_name: @name,
        gross_monthly_income: gross_monthly_income.round(2),
        monthly_income_tax: monthly_income_tax.round(2),
        net_monthly_income: net_monthly_income.round(2)
      }
    end
  end
end
