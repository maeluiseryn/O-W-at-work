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

ActiveRecord::Schema.define(:version => 20110319214946) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.integer  "street_number"
    t.integer  "zip"
    t.string   "city"
    t.string   "country"
    t.integer  "place_id"
    t.string   "place_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client_state"
    t.string   "titre"
    t.string   "reference"
    t.string   "client_type"
    t.string   "society"
  end

  create_table "contacts", :force => true do |t|
    t.string   "description"
    t.string   "genre"
    t.string   "contact_data"
    t.integer  "contact_ref_id"
    t.string   "contact_ref_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financial_datas", :force => true do |t|
    t.string   "tva_number"
    t.string   "tva_rate"
    t.string   "bank_account"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "projects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "uploaded_files", :force => true do |t|
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.string   "content_type"
    t.integer  "file_size"
    t.integer  "file_owner_id"
    t.string   "file_owner_type"
  end

  create_table "user_clients", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "join_type"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "surname"
  end

  create_table "user_projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
  end

end
