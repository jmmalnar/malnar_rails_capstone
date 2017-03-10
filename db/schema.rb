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

ActiveRecord::Schema.define(version: 20170310142935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "doctors", ["user_id"], name: "index_doctors_on_user_id", using: :btree

  create_table "patient_entries", force: :cascade do |t|
    t.integer  "pain_level"
    t.integer  "sample_color"
    t.float    "drain_quantity"
    t.text     "note"
    t.datetime "date_of_sample"
    t.integer  "patient_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "patient_entries", ["patient_id"], name: "index_patient_entries_on_patient_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "patients", ["doctor_id"], name: "index_patients_on_doctor_id", using: :btree
  add_index "patients", ["user_id"], name: "index_patients_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
  end

  add_foreign_key "doctors", "users"
  add_foreign_key "patient_entries", "patients"
  add_foreign_key "patients", "doctors"
  add_foreign_key "patients", "users"
end
