class CreateSragRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :srag_records do |t|
      t.references :srag, null: false, foreign_key: true, index: true
      t.date    :dt_notific
      t.string  :sem_not
      t.date    :dt_sin_pri
      t.string  :sem_pri, limit: 16
      t.string  :sg_uf_not, limit: 4
      t.string  :id_regiona, limit: 16
      t.string  :co_regiona, limit: 16
      t.string  :id_municip, limit: 16
      t.string  :co_mun_not, limit: 16
      t.string  :id_unidade, limit: 16
      t.string  :co_uni_not, limit: 16
      t.string  :cs_sexo, limit: 4
      t.date    :dt_nasc
      t.integer :nu_idade_n, limit: 4
      t.string  :tp_idade, limit: 4
      t.string  :cod_idade
      t.string  :cs_gestant, limit: 4
      t.string  :cs_raca, limit: 4
      t.string  :cs_escol_n, limit: 4
      t.string  :id_pais, limit: 16
      t.string  :co_pais, limit: 16
      t.string  :sg_uf, limit: 4
      t.string  :id_rg_resi, limit: 16
      t.string  :co_rg_resi, limit: 16
      t.string  :id_mn_resi, limit: 16
      t.string  :co_mun_res, limit: 16
      t.string  :cs_zona, limit: 4
      t.string  :surto_sg
      t.string  :nosocomial, limit: 4
      t.string  :ave_suino, limit: 4
      t.string  :febre, limit: 4
      t.string  :tosse, limit: 4
      t.string  :garganta, limit: 4
      t.string  :dispneia, limit: 4
      t.string  :desc_resp, limit: 4
      t.string  :saturacao, limit: 4
      t.string  :diarreia, limit: 4
      t.string  :vomito, limit: 4
      t.string  :outro_sin
      t.string  :outro_des, limit: 1024
      t.string  :puerpera, limit: 4
      t.string  :fator_risc, limit: 4
      t.string  :cardiopati, limit: 4
      t.string  :hematologi, limit: 4
      t.string  :sind_down, limit: 4
      t.string  :hepatica, limit: 4
      t.string  :asma, limit: 4
      t.string  :diabetes, limit: 4
      t.string  :neurologic, limit: 4
      t.string  :pneumopati, limit: 4
      t.string  :imunodepre, limit: 4
      t.string  :renal, limit: 4
      t.string  :obesidade, limit: 4
      t.string  :obes_imc, limit: 8
      t.string  :out_morbi
      t.string  :morb_desc, limit: 1024
      t.integer :vacina
      t.date    :dt_ut_dose
      t.string  :mae_vac, limit: 4
      t.date    :dt_vac_mae
      t.string  :m_amamenta, limit: 4
      t.date    :dt_doseuni
      t.date    :dt_1_dose
      t.date    :dt_2_dose
      t.string  :antiviral, limit: 4
      t.string  :tp_antivir, limit: 4
      t.string  :out_antiv, limit: 64
      t.date    :dt_antivir
      t.integer :hospital
      t.date    :dt_interna
      t.string  :sg_uf_inte, limit: 4
      t.string  :id_rg_inte, limit: 8
      t.string  :co_rg_inte, limit: 8
      t.string  :id_mn_inte, limit: 32
      t.string  :co_mu_inte, limit: 32
      t.integer :uti
      t.date    :dt_entuti
      t.date    :dt_saiduti
      t.integer :suport_ven
      t.string  :raiox_res, limit: 4
      t.string  :raiox_out, limit: 32
      t.date    :dt_raiox
      t.string  :amostra, limit: 4
      t.date    :dt_coleta
      t.string  :tp_amostra, limit: 48
      t.string  :out_amost, limit: 64
      t.string  :pcr_resul, limit: 4
      t.date    :dt_pcr
      t.string  :pos_pcrflu, limit: 4
      t.string  :tp_flu_pcr, limit: 4
      t.string  :pcr_fluasu, limit: 4
      t.string  :fluasu_out, limit: 48
      t.string  :pcr_flubli, limit: 4
      t.string  :flubli_out, limit: 48
      t.string  :pos_pcrout, limit: 4
      t.string  :pcr_vsr, limit: 4
      t.string  :pcr_para1, limit: 4
      t.string  :pcr_para2, limit: 4
      t.string  :pcr_para3, limit: 4
      t.string  :pcr_para4, limit: 4
      t.string  :pcr_adeno, limit: 4
      t.string  :pcr_metap, limit: 4
      t.string  :pcr_boca, limit: 4
      t.string  :pcr_rino, limit: 4
      t.string  :pcr_outro
      t.string  :ds_pcr_out, limit: 256
      t.integer :classi_fin
      t.string  :classi_out, limit: 128
      t.string  :criterio, limit: 4
      t.integer :evolucao
      t.date    :dt_evoluca
      t.date    :dt_encerra
      t.date    :dt_digita
      t.string  :histo_vgm
      t.string  :pais_vgm
      t.string  :co_ps_vgm
      t.string  :lo_ps_vgm
      t.string  :dt_vgm
      t.string  :dt_rt_vgm
      t.string  :pcr_sars2
      t.string  :pac_cocbo, limit: 32
      t.string  :pac_dscbo, limit: 128
      t.string  :out_anim, limit: 128
      t.string  :dor_abd, limit: 4
      t.string  :fadiga, limit: 4
      t.string  :perd_olft, limit: 4
      t.string  :perd_pala, limit: 4
      t.string  :tomo_res, limit: 16
      t.string  :tomo_out, limit: 256
      t.date    :dt_tomo
      t.string  :tp_tes_an, limit: 4
      t.date    :dt_res_an
      t.string  :res_an, limit: 4
      t.string  :pos_an_flu, limit: 4
      t.string  :tp_flu_an, limit: 4
      t.string  :pos_an_out, limit: 4
      t.string  :an_sars2, limit: 4
      t.string  :an_vsr, limit: 4
      t.string  :an_para1, limit: 4
      t.string  :an_para2, limit: 4
      t.string  :an_para3, limit: 4
      t.string  :an_adeno, limit: 4
      t.string  :an_outro
      t.string  :ds_an_out, limit: 128
      t.string  :tp_am_sor, limit: 4
      t.string  :sor_out, limit: 256
      t.date    :dt_co_sor
      t.string  :tp_sor, limit: 4
      t.string  :out_sor, limit: 256
      t.date    :dt_res
      t.string  :res_igg, limit: 4
      t.string  :res_igm, limit: 4
      t.string  :res_iga, limit: 4
      t.string  :estrang, limit: 4
      t.integer :vacina_cov
      t.date    :dose_1_cov
      t.date    :dose_2_cov
      t.date    :dose_ref
      t.string  :fab_cov_1, limit: 256
      t.string  :fab_cov_2, limit: 256
      t.string  :fab_covref, limit: 256
      t.string  :lote_ref, limit: 32
      t.string  :lab_pr_cov
      t.string  :lote_1_cov, limit: 32
      t.string  :lote_2_cov, limit: 32
      t.integer :fnt_in_cov

      t.timestamps
    end
  end
end
