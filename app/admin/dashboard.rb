ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "This Month Expenses" do
          table do
            thead do
              tr do
                th do
                  I18n.t("dashboard.price_type")
                end
                th do
                  I18n.t("dashboard.price_summary")
                end
              end
            end
            tbody do
              tr do
                th do
                  I18n.t("dashboard.expense")
                end
                td do
                  link_to Expense.where(paid_on: (Date.today.beginning_of_month)..(Date.today.end_of_month)).sum(:price),
                          admin_expenses_path(
                            "q[paid_on_gteq]" => Date.today.beginning_of_month,
                            "q[paid_on_lteq]" => Date.today.end_of_month,
                            commit: "Filter"
                          )
                end
              end
              tr do
                th do
                  I18n.t("dashboard.income")
                end
                td do
                  link_to Income.where(earned_on: (Date.today.beginning_of_month)..(Date.today.end_of_month)).sum(:price),
                          admin_incomes_path(
                            "q[earned_on_gteq]" => Date.today.beginning_of_month,
                            "q[earned_on_lteq]" => Date.today.end_of_month,
                            commit: "Filter"
                          )
                end
              end
            end
          end

          table_for Expense.joins(:expense_type)
                           .select("expenses.expense_type_id, expense_types.name as expense_types_name, sum(expenses.price) as expenses_price")
                           .where(paid_on: (Date.today.beginning_of_month)..(Date.today.end_of_month))
                           .group(:expense_type_id)
                           .order("expenses_price DESC") do
            column(:expense_type) { |expense| expense.expense_types_name }
            column(:price) { |expense| link_to expense.expenses_price, admin_expenses_path(
              "q[expense_type_id_eq]" => expense.expense_type_id,
              "q[paid_on_gteq]" => Date.today.beginning_of_month,
              "q[paid_on_lteq]" => Date.today.end_of_month,
              commit: "Filter"
            ) }
          end
        end
      end

      column do
        panel "Last Month Expenses" do
          table do
            thead do
              tr do
                th do
                  I18n.t("dashboard.price_type")
                end
                th do
                  I18n.t("dashboard.price_summary")
                end
              end
            end
            tbody do
              tr do
                th do
                  I18n.t("dashboard.expense")
                end
                td do
                  link_to Expense.where(paid_on: (Date.today.prev_month.beginning_of_month)..(Date.today.prev_month.end_of_month)).sum(:price),
                          admin_expenses_path(
                            "q[paid_on_gteq]" => Date.today.prev_month.beginning_of_month,
                            "q[paid_on_lteq]" => Date.today.prev_month.end_of_month,
                            commit: "Filter"
                          )
                end
              end
              tr do
                th do
                  I18n.t("dashboard.income")
                end
                td do
                  link_to Income.where(earned_on: (Date.today.prev_month.beginning_of_month)..(Date.today.prev_month.end_of_month)).sum(:price),
                          admin_incomes_path(
                            "q[earned_on_gteq]" => Date.today.prev_month.beginning_of_month,
                            "q[earned_on_lteq]" => Date.today.prev_month.end_of_month,
                            commit: "Filter"
                          )
                end
              end
            end
          end
          table_for Expense.joins(:expense_type)
                           .select("expenses.expense_type_id, expense_types.name as expense_types_name, sum(expenses.price) as expenses_price")
                           .where(paid_on: (Date.today.prev_month.beginning_of_month)..(Date.today.prev_month.end_of_month))
                           .group(:expense_type_id)
                           .order("expenses_price DESC") do
            column(:expense_type) { |expense| expense.expense_types_name }
            column(:price) { |expense| link_to expense.expenses_price, admin_expenses_path(
              "q[expense_type_id_eq]" => expense.expense_type_id,
              "q[paid_on_gteq]" => Date.today.prev_month.beginning_of_month,
              "q[paid_on_lteq]" => Date.today.prev_month.end_of_month,
              commit: "Filter"
            ) }
          end
        end
      end
    end
  end # content
end
