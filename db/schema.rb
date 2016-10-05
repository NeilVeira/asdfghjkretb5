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

ActiveRecord::Schema.define(version: 20161005180718) do

  create_table "golf_course_organizers", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.integer  "adminrights"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_golf_course_organizers_on_person_id"
    t.index ["tournament_id"], name: "index_golf_course_organizers_on_tournament_id"
  end

  create_table "golf_courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "location"
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "dob"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "location"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_players_on_person_id"
    t.index ["tournament_id"], name: "index_players_on_tournament_id"
  end

  create_table "registered_people", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_registered_people_on_person_id"
    t.index ["tournament_id"], name: "index_registered_people_on_tournament_id"
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["person_id"], name: "index_sponsors_on_person_id"
    t.index ["tournament_id"], name: "index_sponsors_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "tickettype"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_tickets_on_person_id"
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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "golf_course_id"
    t.index ["golf_course_id"], name: "index_tournaments_on_golf_course_id"
  end

  create_table "website_admins", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "adminrights"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["person_id"], name: "index_website_admins_on_person_id"
  end

end
