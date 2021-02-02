ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Expenses" do
          ul do
            Expense.order(id: :desc).limit(20).map do |expense|
              text = expense.paid_on.to_s + ' ' + expense.name.to_s + ' ' + expense.price.to_s
              li link_to(text, admin_expense_path(expense))
            end
          end
        end
      end
      column do
        panel "Recent Income" do
          ul do
            Income.order(id: :desc).limit(20).map do |income|
              text = income.earned_on.to_s + ' ' + income.name.to_s + ' ' + income.price.to_s
              li link_to(text, admin_expense_path(income))
            end
          end
        end
      end
    end

  end # content
end
