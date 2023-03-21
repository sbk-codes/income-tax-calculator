module Payslip
  class Print < ApplicationService
    def initialize(name, annual_salary)
      @name = name
      @annual_salary = annual_salary
    end

    def call
      generate_monthly_payslip
    end

    def generate_monthly_payslip
      output = Payslip::Generate.call(@name, @annual_salary)

      puts "Monthly Payslip for: #{output[:employee_name]}"
      puts "Gross Monthly Income: $#{format('%.2f', output[:gross_monthly_income])}"
      puts "Monthly Income Tax: $#{format('%.2f', output[:monthly_income_tax])}"
      puts "Net Monthly Income: $#{format('%.2f', output[:net_monthly_income])}"
    end
  end
end
