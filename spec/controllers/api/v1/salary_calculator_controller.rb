require 'rails_helper'

RSpec.describe Api::V1::SalaryCalculatorController, type: :controller do
  describe 'POST #calculate' do
    let(:employee_name) { 'John Doe' }
    
    context 'with valid parameters' do
      let(:annual_salary) { 60000 }
      
      it 'returns HTTP success' do
        post :calculate, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(response).to have_http_status(:success)
      end
      
      it 'returns the correct JSON response' do
        post :calculate, params: { employee_name: employee_name, annual_salary: annual_salary }
        output = JSON.parse(response.body).with_indifferent_access
        expect(output[:employee_name]).to eq(employee_name)
        expect(output[:gross_monthly_income]).to eq(5000.0)
        expect(output[:monthly_income_tax]).to eq(500.0)
        expect(output[:net_monthly_income]).to eq(4500.0)
      end
    end
    
    context 'with invalid parameters' do
      let(:annual_salary) { -50000 }
      
      it 'returns HTTP bad request' do
        post :calculate, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(response).to have_http_status(:bad_request)
      end
      
      it 'returns the correct error message' do
        post :calculate, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(JSON.parse(response.body)).to eq({
          'error' => 'Enter valid employee name & annual salary'
        })
      end
    end
  end
end
