class Income < ApplicationRecord
  belongs_to :admin_user
  belongs_to :income_type
end
