class Api::V1::SalaryCalculatorController < ApplicationController
  def create
    employee_name = params[:employee_name]
    annual_salary = params[:annual_salary].to_i

    if !employee_name.present? || !annual_salary.present? || annual_salary < 0
      render json: { error: 'Enter valid employee name & annual salary' }, status: :bad_request
    else
      payslip_data = Payslip::Generate.call(employee_name, annual_salary)
      salary = Salary.new(timestamp: Time.now, employee_name: employee_name, annual_salary: annual_salary, monthly_income_tax: payslip_data[:monthly_income_tax])

      if salary.save
        render json: payslip_data, status: :ok
      else
        render json: {error: salary.errors.full_messages }, status: :bad_request
      end
    end
  end

  def show
    salary = Salary.find_by(id: params[:id])

    if salary
      render json: { salary_computations: [ salary.result_set ] }, status: :ok
    else
      render json: { error: "Could not find salary for the id: #{params[:id]}" }, status: :bad_request
    end
  end
end
