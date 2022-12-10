# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_09_110756) do
  create_table "access_codes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "srag_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "srag_id", null: false
    t.date "dt_notific"
    t.string "sem_not"
    t.date "dt_sin_pri"
    t.string "sem_pri", limit: 128
    t.string "sg_uf_not", limit: 24
    t.string "id_regiona"
    t.string "co_regiona", limit: 128
    t.string "id_municip", limit: 128
    t.string "co_mun_not", limit: 128
    t.string "id_unidade"
    t.string "co_uni_not", limit: 128
    t.string "cs_sexo", limit: 24
    t.date "dt_nasc"
    t.integer "nu_idade_n"
    t.string "tp_idade", limit: 24
    t.string "cod_idade"
    t.string "cs_gestant", limit: 24
    t.string "cs_raca", limit: 24
    t.string "cs_escol_n", limit: 24
    t.string "id_pais", limit: 128
    t.string "co_pais", limit: 128
    t.string "sg_uf", limit: 24
    t.string "id_rg_resi"
    t.string "co_rg_resi"
    t.string "id_mn_resi", limit: 128
    t.string "co_mun_res", limit: 128
    t.string "cs_zona", limit: 24
    t.string "surto_sg"
    t.string "nosocomial", limit: 24
    t.string "ave_suino", limit: 24
    t.string "febre", limit: 24
    t.string "tosse", limit: 24
    t.string "garganta", limit: 24
    t.string "dispneia", limit: 24
    t.string "desc_resp", limit: 24
    t.string "saturacao", limit: 24
    t.string "diarreia", limit: 24
    t.string "vomito", limit: 24
    t.string "outro_sin"
    t.string "outro_des", limit: 1024
    t.string "puerpera", limit: 24
    t.string "fator_risc", limit: 24
    t.string "cardiopati", limit: 24
    t.string "hematologi", limit: 24
    t.string "sind_down", limit: 24
    t.string "hepatica", limit: 24
    t.string "asma", limit: 24
    t.string "diabetes", limit: 24
    t.string "neurologic", limit: 24
    t.string "pneumopati", limit: 24
    t.string "imunodepre", limit: 24
    t.string "renal", limit: 24
    t.string "obesidade", limit: 24
    t.string "obes_imc", limit: 32
    t.string "out_morbi"
    t.string "morb_desc", limit: 1024
    t.integer "vacina"
    t.date "dt_ut_dose"
    t.string "mae_vac", limit: 24
    t.date "dt_vac_mae"
    t.string "m_amamenta", limit: 24
    t.date "dt_doseuni"
    t.date "dt_1_dose"
    t.date "dt_2_dose"
    t.string "antiviral", limit: 24
    t.string "tp_antivir", limit: 24
    t.string "out_antiv", limit: 100
    t.date "dt_antivir"
    t.integer "hospital"
    t.date "dt_interna"
    t.string "sg_uf_inte", limit: 24
    t.string "id_rg_inte"
    t.string "co_rg_inte"
    t.string "id_mn_inte", limit: 128
    t.string "co_mu_inte", limit: 128
    t.integer "uti"
    t.date "dt_entuti"
    t.date "dt_saiduti"
    t.integer "suport_ven"
    t.string "raiox_res", limit: 24
    t.string "raiox_out", limit: 256
    t.date "dt_raiox"
    t.string "amostra", limit: 24
    t.date "dt_coleta"
    t.string "tp_amostra", limit: 248
    t.string "out_amost", limit: 100
    t.string "pcr_resul", limit: 24
    t.date "dt_pcr"
    t.string "pos_pcrflu", limit: 24
    t.string "tp_flu_pcr", limit: 24
    t.string "pcr_fluasu", limit: 24
    t.string "fluasu_out", limit: 248
    t.string "pcr_flubli", limit: 24
    t.string "flubli_out", limit: 248
    t.string "pos_pcrout", limit: 24
    t.string "pcr_vsr", limit: 24
    t.string "pcr_para1", limit: 24
    t.string "pcr_para2", limit: 24
    t.string "pcr_para3", limit: 24
    t.string "pcr_para4", limit: 24
    t.string "pcr_adeno", limit: 24
    t.string "pcr_metap", limit: 24
    t.string "pcr_boca", limit: 24
    t.string "pcr_rino", limit: 24
    t.string "pcr_outro"
    t.string "ds_pcr_out", limit: 256
    t.integer "classi_fin"
    t.string "classi_out", limit: 248
    t.string "criterio", limit: 24
    t.integer "evolucao"
    t.date "dt_evoluca"
    t.date "dt_encerra"
    t.date "dt_digita"
    t.string "histo_vgm"
    t.string "pais_vgm"
    t.string "co_ps_vgm"
    t.string "lo_ps_vgm"
    t.string "dt_vgm"
    t.string "dt_rt_vgm"
    t.string "pcr_sars2"
    t.string "pac_cocbo", limit: 32
    t.string "pac_dscbo", limit: 248
    t.string "out_anim", limit: 248
    t.string "dor_abd", limit: 24
    t.string "fadiga", limit: 24
    t.string "perd_olft", limit: 24
    t.string "perd_pala", limit: 24
    t.string "tomo_res", limit: 128
    t.string "tomo_out", limit: 256
    t.date "dt_tomo"
    t.string "tp_tes_an", limit: 24
    t.date "dt_res_an"
    t.string "res_an", limit: 24
    t.string "pos_an_flu", limit: 24
    t.string "tp_flu_an", limit: 24
    t.string "pos_an_out", limit: 24
    t.string "an_sars2", limit: 24
    t.string "an_vsr", limit: 24
    t.string "an_para1", limit: 24
    t.string "an_para2", limit: 24
    t.string "an_para3", limit: 24
    t.string "an_adeno", limit: 24
    t.string "an_outro"
    t.string "ds_an_out", limit: 248
    t.string "tp_am_sor", limit: 24
    t.string "sor_out", limit: 256
    t.date "dt_co_sor"
    t.string "tp_sor", limit: 24
    t.string "out_sor", limit: 256
    t.date "dt_res"
    t.string "res_igg", limit: 24
    t.string "res_igm", limit: 24
    t.string "res_iga", limit: 24
    t.string "estrang", limit: 24
    t.integer "vacina_cov"
    t.date "dose_1_cov"
    t.date "dose_2_cov"
    t.date "dose_ref"
    t.string "fab_cov_1", limit: 256
    t.string "fab_cov_2", limit: 256
    t.string "fab_covref", limit: 256
    t.string "lote_ref", limit: 128
    t.string "lab_pr_cov"
    t.string "lote_1_cov", limit: 128
    t.string "lote_2_cov", limit: 128
    t.integer "fnt_in_cov"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["srag_id"], name: "index_srag_records_on_srag_id"
  end

  create_table "srags", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year"
    t.date "release_date"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", limit: 24, default: "CREATED", null: false
    t.boolean "downloaded", default: false, null: false
    t.text "report"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false, null: false
    t.boolean "active", default: false, null: false
    t.datetime "activation_date"
    t.string "activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vaccination_numbers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.decimal "one_dose", precision: 10, default: "0", null: false
    t.decimal "two_doses", precision: 10, default: "0", null: false
    t.decimal "boosted", precision: 10, default: "0", null: false
    t.string "country", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year", "month"], name: "index_vaccination_numbers_on_year_and_month", unique: true
  end

  add_foreign_key "srag_records", "srags"
end
