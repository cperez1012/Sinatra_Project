# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20191219214545) do

  create_table "institutions", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.integer "year_founded"
    t.string  "industry"
    t.string  "image_url"
    t.integer "user_id"
  end

  create_table "investments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "institution_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "price"
    t.integer "number_of_stocks"
    t.integer "institution_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "email"
    t.string  "password_digest"
    t.integer "wallet"
  end

end
