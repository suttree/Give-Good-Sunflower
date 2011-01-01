# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110101111231) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "tweet_id",            :limit => 8, :null => false
    t.string   "twitter_screen_name"
    t.text     "url",                              :null => false
    t.text     "favicon"
    t.text     "title"
    t.text     "author"
    t.text     "lede"
    t.text     "html_body"
    t.text     "body"
    t.text     "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "read_at"
  end

  create_table "email_addresses", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_accounts", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.string   "remote_account_id"
    t.string   "name"
    t.string   "login"
    t.string   "picture_url"
    t.string   "token"
    t.string   "secret"
    t.text     "user_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "login_accounts", ["type", "remote_account_id"], :name => "type_remote_acc_id"
  add_index "login_accounts", ["type"], :name => "index_login_accounts_on_type"
  add_index "login_accounts", ["user_id"], :name => "index_login_accounts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_tweet_id",  :limit => 8
  end

end
