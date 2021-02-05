ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel "This Month Expenses" do
          table_for Expense.joins(:expense_type)
                           .select('expenses.expense_type_id, expense_types.name as expense_types_name, sum(expenses.price) as expenses_price')
                           .where(paid_on: (Date.today.beginning_of_month)..(Date.today.end_of_month))
                           .group(:expense_type_id)
                           .order("expenses_price DESC") do
            column(:expense_type) { |expense| expense.expense_types_name }
            column(:price) { |expense| expense.expenses_price }
          end
        end
      end

      column do
        panel "This Month Incomes" do
          table_for Income.joins(:income_type)
                          .select('incomes.income_type_id, income_types.name as income_types_name, sum(incomes.price) as incomes_price')
                          .where(earned_on: (Date.today.beginning_of_month)..(Date.today.end_of_month))
                          .group(:income_type_id)
                          .order("incomes_price DESC") do
            column(:income_type) { |income| income.income_types_name }
            column(:price) { |income| income.incomes_price }
          end
        end
      end
    end

    columns do
      column do
        panel "Last Month Expenses" do
          table_for Expense.joins(:expense_type)
                           .select('expenses.expense_type_id, expense_types.name as expense_types_name, sum(expenses.price) as expenses_price')
                           .where(paid_on: (Date.today.prev_month.beginning_of_month)..(Date.today.prev_month.end_of_month))
                           .group(:expense_type_id)
                           .order("expenses_price DESC") do
            column(:expense_type) { |expense| expense.expense_types_name }
            column(:price) { |expense| expense.expenses_price }
          end
        end
      end

      column do
        panel "Last Month Incomes" do
          table_for Income.joins(:income_type)
                          .select('incomes.income_type_id, income_types.name as income_types_name, sum(incomes.price) as incomes_price')
                          .where(earned_on: (Date.today.prev_month.beginning_of_month)..(Date.today.prev_month.end_of_month))
                          .group(:income_type_id)
                          .order("incomes_price DESC") do
            column(:income_type) { |income| income.income_types_name }
            column(:price) { |income| income.incomes_price }
          end
        end
      end
    end

  end # content
end
