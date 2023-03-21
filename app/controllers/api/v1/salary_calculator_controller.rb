class Api::V1::SalaryCalculatorController < ApplicationController
  def calculate
    employee_name = params[:employee_name]
    annual_salary = params[:annual_salary].to_i

    if employee_name.nil? || annual_salary.nil? || annual_salary < 0
      render json: { error: 'Enter valid employee name & annual salary' }, status: :bad_request
    else
      payslip = Payslip::Generate.call(employee_name, annual_salary)
      render json: payslip, status: :ok
    end
  end
end
