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

ActiveRecord::Schema.define(version: 20161119172116) do

  create_table "addresses", force: :cascade do |t|
    t.string   "addressType"
    t.integer  "apartmentNumber"
    t.integer  "streetNumber"
    t.string   "streetName"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "postalCode"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "golf_course_organizers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "adminrights"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "golf_course_id"
    t.index ["golf_course_id"], name: "index_golf_course_organizers_on_golf_course_id"
    t.index ["person_id"], name: "index_golf_course_organizers_on_person_id"
  end

  create_table "golf_courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "address_id"
    t.index ["address_id"], name: "index_golf_courses_on_address_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "dob"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "address_id"
    t.index ["address_id"], name: "index_people_on_address_id"
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "team_id"
    t.index ["person_id"], name: "index_players_on_person_id"
    t.index ["team_id"], name: "index_players_on_team_id"
    t.index ["tournament_id"], name: "index_players_on_tournament_id"
  end

  create_table "registered_teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_registered_teams_on_person_id"
    t.index ["tournament_id"], name: "index_registered_teams_on_tournament_id"
  end

  create_table "sponsors", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.string   "website"
    t.string   "contact_info"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.index ["person_id"], name: "index_sponsors_on_person_id"
    t.index ["tournament_id"], name: "index_sponsors_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "p1_id"
    t.integer  "p2_id"
    t.integer  "p3_id"
    t.integer  "p4_id"
    t.index ["p1_id"], name: "index_teams_on_p1_id"
    t.index ["p2_id"], name: "index_teams_on_p2_id"
    t.index ["p3_id"], name: "index_teams_on_p3_id"
    t.index ["p4_id"], name: "index_teams_on_p4_id"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "tickettype"
    t.integer  "person_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "tournament_id"
    t.index ["person_id"], name: "index_tickets_on_person_id"
    t.index ["tournament_id"], name: "index_tickets_on_tournament_id"
  end

  create_table "tournament_organizers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.integer  "adminrights"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_tournament_organizers_on_person_id"
    t.index ["tournament_id"], name: "index_tournament_organizers_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "ispublic"
    t.text     "extrafeatures"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "golf_course_id"
    t.datetime "date"
    t.decimal  "pricePlayer",        precision: 6, scale: 2
    t.decimal  "priceSpectator",     precision: 6, scale: 2
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["golf_course_id"], name: "index_tournaments_on_golf_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "website_admins", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "adminrights"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["person_id"], name: "index_website_admins_on_person_id"
  end

end
