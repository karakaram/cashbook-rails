class Expense < ApplicationRecord
  belongs_to :admin_user
  belongs_to :expense_type
end
