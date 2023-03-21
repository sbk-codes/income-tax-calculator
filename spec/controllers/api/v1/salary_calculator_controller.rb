require 'rails_helper'

RSpec.describe Api::V1::SalaryCalculatorController, type: :controller do
  describe 'POST #create' do
    let(:employee_name) { 'John Doe' }

    context 'with valid parameters' do
      let(:annual_salary) { 60_000 }

      it 'returns HTTP success' do
        post :create, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct JSON response' do
        expect do
          post :create, params: { employee_name: employee_name, annual_salary: annual_salary }
        end.to change(Salary, :count).by(1)
        output = JSON.parse(response.body).with_indifferent_access
        expect(output[:employee_name]).to eq(employee_name)
        expect(output[:gross_monthly_income]).to eq(5000.0)
        expect(output[:monthly_income_tax]).to eq(500.0)
        expect(output[:net_monthly_income]).to eq(4500.0)
      end
    end

    context 'with invalid parameters' do
      let(:annual_salary) { -50_000 }

      it 'returns HTTP bad request' do
        post :create, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns the correct error message' do
        post :create, params: { employee_name: employee_name, annual_salary: annual_salary }
        expect(JSON.parse(response.body)).to eq({
                                                  'error' => 'Enter valid employee name & annual salary'
                                                })
      end
    end
  end

  describe 'POST #show' do
    let(:salary) do
      Salary.create(timestamp: Time.now, employee_name: 'abc', annual_salary: 60_000.0, monthly_income_tax: 500.0)
    end

    context 'with valid parameters' do
      let(:id) { salary.id }

      it 'returns HTTP success' do
        get :show, params: { id: id }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct JSON response' do
        get :show, params: { id: id }
        output = JSON.parse(response.body).with_indifferent_access[:salary_computations].first
        expect(output[:employee_name]).to eq('abc')
        expect(output[:annual_salary]).to eq('60000.0')
        expect(output[:monthly_income_tax]).to eq('500.0')
      end
    end

    context 'with invalid parameters' do
      let(:id) { 1000 }

      it 'returns HTTP bad request' do
        get :show, params: { id: id }
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns the correct error message' do
        get :show, params: { id: id }
        expect(JSON.parse(response.body)).to eq({
                                                  'error' => "Could not find salary for the id: #{id}"
                                                })
      end
    end
  end
end
