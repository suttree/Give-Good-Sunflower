class CreateOmnisocialTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :remember_token
      # Any additional fields here

      t.timestamps
    end

    create_table :login_accounts do |t|
      t.string :type
      t.integer :user_id
      t.string :remote_account_id
      t.string :name
      t.string :login
      t.string :picture_url
      # Any additional fields here
      t.string :token
      t.string :secret
      t.text :user_hash

      t.timestamps
    end
    create_table :email_addresses do |t|
      t.string :email
      t.references :user

      t.timestamps
    end

    add_index :login_accounts, :user_id
    add_index :login_accounts, :type
    add_index :login_accounts, [:type, :remote_account_id], :name => 'type_remote_acc_id'
  end

  def self.down
    remove_index :login_accounts, :name => 'type_remote_acc_id'
    remove_index :login_accounts, :type
    remove_index :login_accounts, :user_id
    drop_table :email_addresses
    drop_table :login_accounts
    drop_table :users
  end
end
