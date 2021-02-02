ActiveAdmin.register RegularExpense do
  permit_params :admin_user_id, :expense_type_id, :price, :name

  form do |f|
    if params[:action] == 'new'
      f.object.admin_user = current_admin_user
    end

    f.inputs do
      f.input :admin_user, as: :select, collection: AdminUser.pluck(:email, :id), include_blank: false
      f.input :expense_type, include_blank: false
      f.input :price
      f.input :name
    end
    f.actions
  end
end
