require 'rails_helper'

RSpec.describe Payslip::Generate, type: :service do
  describe '#call' do
    subject { described_class.call(name, annual_salary) }

    describe '#call' do
      let(:name) { 'John Doe' }
      let(:annual_salary) { 20_000 }

      it 'returns a Hash' do
        expect(subject).to be_a(Hash)
      end
    end

    context 'when the annual salary is same as an example' do
      let(:name) { 'Ren' }
      let(:annual_salary) { 60_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'Ren',
          gross_monthly_income: 5000.0,
          monthly_income_tax: 500.0,
          net_monthly_income: 4500.0
        })
      end
    end

    context 'when the annual salary is less than or equal to 20,000' do
      let(:name) { 'John Doe' }
      let(:annual_salary) { 20_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'John Doe',
          gross_monthly_income: 1666.67,
          monthly_income_tax: 0.0,
          net_monthly_income: 1666.67
        })
      end
    end

    context 'when the annual salary is between 20,001 and 40,000' do
      let(:name) { 'Jane Smith' }
      let(:annual_salary) { 30_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'Jane Smith',
          gross_monthly_income: 2500.0,
          monthly_income_tax: 83.33,
          net_monthly_income: 2416.67
        })
      end
    end

    context 'when the annual salary is between 40,001 and 80,000' do
      let(:name) { 'Bob Johnson' }
      let(:annual_salary) { 60_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'Bob Johnson',
          gross_monthly_income: 5000.0,
          monthly_income_tax: 500.0,
          net_monthly_income: 4500.0
        })
      end
    end

    context 'when the annual salary is between 80,001 and 180,000' do
      let(:name) { 'Alice Lee' }
      let(:annual_salary) { 120_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'Alice Lee',
          gross_monthly_income: 10000.0,
          monthly_income_tax: 1833.33,
          net_monthly_income: 8166.67
        })
      end
    end

    context 'when the annual salary is greater than 180,000' do
      let(:name) { 'Tom Davis' }
      let(:annual_salary) { 250_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq({
          employee_name: 'Tom Davis',
          gross_monthly_income: 20833.33,
          monthly_income_tax: 5666.67,
          net_monthly_income: 15166.67
        })
      end
    end
  end
end
