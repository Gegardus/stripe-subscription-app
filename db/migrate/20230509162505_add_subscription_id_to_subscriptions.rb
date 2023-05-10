class AddSubscriptionIdToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :subscription_id, :string
  end
end
