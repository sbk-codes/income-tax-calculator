class Api::V1::SalaryCalculatorController < ApplicationController
  def create
    employee_name = params[:employee_name]
    annual_salary = params[:annual_salary].to_i

    if employee_name.nil? || annual_salary.nil? || annual_salary < 0
      render json: { error: 'Enter valid employee name & annual salary' }, status: :bad_request
    else
      payslip_data = Payslip::Generate.call(employee_name, annual_salary)
      salary = Salary.new(timestamp: Time.now, employee_name: employee_name, annual_salary: annual_salary, monthly_income_tax: payslip_data[:monthly_income_tax])

      if salary.save
        render json: payslip_data, status: :ok
      else
        render json: {error: errors.full_messages }, status: :bad_request
      end
    end
  end
end
