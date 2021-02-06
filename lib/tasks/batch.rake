namespace :batch do
  desc "Monthly Task"
  task :monthly => :environment do
    RegularExpense.all.each do |regularexpense|
      expense = Expense.new
      expense.admin_user = regularexpense.admin_user
      expense.expense_type = regularexpense.expense_type
      expense.paid_on = Date.today
      expense.price = regularexpense.price
      expense.name = regularexpense.name
      expense.save
    end
  end
end
