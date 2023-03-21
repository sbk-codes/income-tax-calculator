require 'rails_helper'

RSpec.describe TaxCalculator::Calculate, type: :service do
  describe '#call' do
    subject { described_class.call(annual_salary) }

    describe '#call' do
      let(:annual_salary) { 20_000 }

      it 'returns a Hash' do
        expect(subject).to be_a(Integer)
      end
    end

    context 'when the annual salary is 60_000' do
      let(:annual_salary) { 60_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq(6000)
      end
    end

    context 'when the annual salary is 200_000' do
      let(:annual_salary) { 200_000 }

      it 'returns the correct monthly payslip information' do
        expect(subject).to eq(48000)
      end
    end
  end
end
