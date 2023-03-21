class Salary < ApplicationRecord
  def result_set
    {
      timestamp: timestamp,
      employee_name: employee_name,
      annual_salary: annual_salary,
      monthly_income_tax: monthly_income_tax
    }
  end
end
