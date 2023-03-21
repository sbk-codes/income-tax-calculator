class CreatePayslips < ActiveRecord::Migration[5.1]
  def change
    create_table :salaries do |t|
      t.datetime :timestamp
      t.string :employee_name, null: false
      t.decimal :annual_salary, null: false, default: 0.0
      t.decimal :monthly_income_tax, null: false, default: 0.0

      t.timestamps
    end
  end
end
