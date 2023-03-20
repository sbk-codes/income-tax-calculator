module TaxCalculator
  class Calculate < ApplicationService
    def initialize(annual_salary)
      @annual_salary = annual_salary
    end

    def call
      # [bracket threshold, tax rate, previous tax bracket amount]
      rates = [0,0,0]

      if @annual_salary <= 20000
        rates = [0,0,0]
      elsif @annual_salary <= 40000
        rates = [20000, 0.1, 0]
      elsif @annual_salary <= 80000
        rates = [40000, 0.2, 2000]
      elsif @annual_salary <= 180000
        rates = [80000, 0.3, 10000]
      else
        rates = [180000, 0.4, 40000]
      end

      return ((@annual_salary - rates[0]) * rates[1]) + rates[2]
    end
  end
end
