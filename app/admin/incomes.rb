ActiveAdmin.register Income do
  permit_params :admin_user_id, :income_type_id, :earned_on, :price, :name

  form do |f|
    if params[:action] == 'new'
      f.object.admin_user = current_admin_user
      f.object.earned_on = Date.today
    end

    f.inputs do
      f.input :admin_user, as: :select, collection: AdminUser.pluck(:email, :id), include_blank: false
      f.input :income_type, as: :select, collection: IncomeType.order(:order), include_blank: false
      f.input :earned_on, as: :datepicker
      f.input :price
      f.input :name
    end
    f.actions
  end

  filter :admin_user, as: :select, collection: AdminUser.pluck(:email, :id)
  filter :income_type, as: :select, collection: IncomeType.order(:order)
  filter :earned_on
  filter :price
  filter :name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :admin_user
    column :income_type
    column :earned_on
    column :price
    column :name
    actions
  end

  controller do
    def create
      super do |format|
        if @income.errors.empty?
          format.html { redirect_to new_admin_income_path }
        end
      end
    end
  end
end
