ActiveAdmin.register Expense do
  permit_params :admin_user_id, :expense_type_id, :paid_on, :price, :name

  form do |f|
    if params[:action] == "new"
      f.object.admin_user = current_admin_user
      f.object.paid_on = Date.today
    end

    f.inputs do
      f.input :admin_user, as: :select, collection: AdminUser.pluck(:email, :id), include_blank: false
      f.input :expense_type, as: :select, collection: ExpenseType.order(:order), include_blank: false
      f.input :paid_on, as: :datepicker
      f.input :price
      f.input :name
    end
    f.actions
  end

  filter :admin_user, as: :select, collection: proc { AdminUser.pluck(:email, :id) }
  filter :expense_type, as: :select, collection: proc { ExpenseType.order(:order) }
  filter :paid_on
  filter :price
  filter :name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :admin_user
    column :expense_type
    column :paid_on
    column :price
    column :name
    actions
  end

  controller do
    def create
      super do |format|
        if @expense.errors.empty?
          format.html { redirect_to new_admin_expense_path }
        end
      end
    end
  end
end
