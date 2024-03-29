
require 'open-uri'
require 'csv'

class IngestSragFileJob < ApplicationJob
  queue_as :default

  BATCH_SIZE = 1024

  def perform(srag)
    srag.mutex(40.minutes) do
      ingest(srag)
    end
  end

private

  def ingest(srag)
    local_path = download(srag)

    SragRecord.where(srag: srag).delete_all

    logger.info "Processing #{local_path}"
    srag.update! status: Srag::PROCESSING

    records = []

    CSV.foreach(local_path, headers: true, col_sep: ";") do |row|
      next unless row['CLASSI_FIN'].to_i == 5
      records.append({
        srag_id: srag.id,
        dt_notific:  row["DT_NOTIFIC"].blank? ? row["DT_NOTIFIC"] : Date.strptime(row["DT_NOTIFIC"], '%d/%m/%Y'),
        sem_not:  row["SEM_NOT"],
        dt_sin_pri:  row["DT_SIN_PRI"].blank? ? row["DT_SIN_PRI"] : Date.strptime(row["DT_SIN_PRI"], '%d/%m/%Y'),
        sem_pri:  row["SEM_PRI"],
        sg_uf_not:  row["SG_UF_NOT"],
        id_regiona:  row["ID_REGIONA"],
        co_regiona:  row["CO_REGIONA"],
        id_municip:  row["ID_MUNICIP"],
        co_mun_not:  row["CO_MUN_NOT"],
        id_unidade:  row["ID_UNIDADE"],
        co_uni_not:  row["CO_UNI_NOT"],
        cs_sexo:  row["CS_SEXO"],
        dt_nasc:  row["DT_NASC"].blank? ? row["DT_NASC"] : Date.strptime(row["DT_NASC"], '%d/%m/%Y'),
        nu_idade_n:  row["NU_IDADE_N"].to_i,
        tp_idade:  row["TP_IDADE"],
        cod_idade:  row["COD_IDADE"],
        cs_gestant:  row["CS_GESTANT"],
        cs_raca:  row["CS_RACA"],
        cs_escol_n:  row["CS_ESCOL_N"],
        id_pais:  row["ID_PAIS"],
        co_pais:  row["CO_PAIS"],
        sg_uf:  row["SG_UF"],
        id_rg_resi:  row["ID_RG_RESI"],
        co_rg_resi:  row["CO_RG_RESI"],
        id_mn_resi:  row["ID_MN_RESI"],
        co_mun_res:  row["CO_MUN_RES"],
        cs_zona:  row["CS_ZONA"],
        surto_sg:  row["SURTO_SG"],
        nosocomial:  row["NOSOCOMIAL"],
        ave_suino:  row["AVE_SUINO"],
        febre:  row["FEBRE"],
        tosse:  row["TOSSE"],
        garganta:  row["GARGANTA"],
        dispneia:  row["DISPNEIA"],
        desc_resp:  row["DESC_RESP"],
        saturacao:  row["SATURACAO"],
        diarreia:  row["DIARREIA"],
        vomito:  row["VOMITO"],
        outro_sin:  row["OUTRO_SIN"],
        outro_des:  row["OUTRO_DES"],
        puerpera:  row["PUERPERA"],
        fator_risc:  row["FATOR_RISC"],
        cardiopati:  row["CARDIOPATI"],
        hematologi:  row["HEMATOLOGI"],
        sind_down:  row["SIND_DOWN"],
        hepatica:  row["HEPATICA"],
        asma:  row["ASMA"],
        diabetes:  row["DIABETES"],
        neurologic:  row["NEUROLOGIC"],
        pneumopati:  row["PNEUMOPATI"],
        imunodepre:  row["IMUNODEPRE"],
        renal:  row["RENAL"],
        obesidade:  row["OBESIDADE"],
        obes_imc:  row["OBES_IMC"],
        out_morbi:  row["OUT_MORBI"],
        morb_desc:  row["MORB_DESC"],
        vacina:  row["VACINA"].to_i,
        dt_ut_dose:  row["DT_UT_DOSE"].blank? ? row["DT_UT_DOSE"] : Date.strptime(row["DT_UT_DOSE"], '%d/%m/%Y'),
        mae_vac:  row["MAE_VAC"],
        dt_vac_mae:  row["DT_VAC_MAE"].blank? ? row["DT_VAC_MAE"] : Date.strptime(row["DT_VAC_MAE"], '%d/%m/%Y'),
        m_amamenta:  row["M_AMAMENTA"],
        dt_doseuni:  row["DT_DOSEUNI"].blank? ? row["DT_DOSEUNI"] : Date.strptime(row["DT_DOSEUNI"], '%d/%m/%Y'),
        dt_1_dose:  row["DT_1_DOSE"].blank? ? row["DT_1_DOSE"] : Date.strptime(row["DT_1_DOSE"], '%d/%m/%Y'),
        dt_2_dose:  row["DT_2_DOSE"].blank? ? row["DT_2_DOSE"] : Date.strptime(row["DT_2_DOSE"], '%d/%m/%Y'),
        antiviral:  row["ANTIVIRAL"],
        tp_antivir:  row["TP_ANTIVIR"],
        out_antiv:  row["OUT_ANTIV"],
        dt_antivir:  row["DT_ANTIVIR"].blank? ? row["DT_ANTIVIR"] : Date.strptime(row["DT_ANTIVIR"], '%d/%m/%Y'),
        hospital:  row["HOSPITAL"].to_i,
        dt_interna:  row["DT_INTERNA"].blank? ? row["DT_INTERNA"] : Date.strptime(row["DT_INTERNA"], '%d/%m/%Y'),
        sg_uf_inte:  row["SG_UF_INTE"],
        id_rg_inte:  row["ID_RG_INTE"],
        co_rg_inte:  row["CO_RG_INTE"],
        id_mn_inte:  row["ID_MN_INTE"],
        co_mu_inte:  row["CO_MU_INTE"],
        uti:  row["UTI"].to_i,
        dt_entuti:  row["DT_ENTUTI"].blank? ? row["DT_ENTUTI"] : Date.strptime(row["DT_ENTUTI"], '%d/%m/%Y'),
        dt_saiduti:  row["DT_SAIDUTI"].blank? ? row["DT_SAIDUTI"] : Date.strptime(row["DT_SAIDUTI"], '%d/%m/%Y'),
        suport_ven:  row["SUPORT_VEN"].to_i,
        raiox_res:  row["RAIOX_RES"],
        raiox_out:  row["RAIOX_OUT"],
        dt_raiox:  row["DT_RAIOX"].blank? ? row["DT_RAIOX"] : Date.strptime(row["DT_RAIOX"], '%d/%m/%Y'),
        amostra:  row["AMOSTRA"],
        dt_coleta:  row["DT_COLETA"].blank? ? row["DT_COLETA"] : Date.strptime(row["DT_COLETA"], '%d/%m/%Y'),
        tp_amostra:  row["TP_AMOSTRA"],
        out_amost:  row["OUT_AMOST"],
        pcr_resul:  row["PCR_RESUL"],
        dt_pcr:  row["DT_PCR"].blank? ? row["DT_PCR"] : Date.strptime(row["DT_PCR"], '%d/%m/%Y'),
        pos_pcrflu:  row["POS_PCRFLU"],
        tp_flu_pcr:  row["TP_FLU_PCR"],
        pcr_fluasu:  row["PCR_FLUASU"],
        fluasu_out:  row["FLUASU_OUT"],
        pcr_flubli:  row["PCR_FLUBLI"],
        flubli_out:  row["FLUBLI_OUT"],
        pos_pcrout:  row["POS_PCROUT"],
        pcr_vsr:  row["PCR_VSR"],
        pcr_para1:  row["PCR_PARA1"],
        pcr_para2:  row["PCR_PARA2"],
        pcr_para3:  row["PCR_PARA3"],
        pcr_para4:  row["PCR_PARA4"],
        pcr_adeno:  row["PCR_ADENO"],
        pcr_metap:  row["PCR_METAP"],
        pcr_boca:  row["PCR_BOCA"],
        pcr_rino:  row["PCR_RINO"],
        pcr_outro:  row["PCR_OUTRO"],
        ds_pcr_out:  row["DS_PCR_OUT"],
        classi_fin:  row["CLASSI_FIN"].to_i,
        classi_out:  row["CLASSI_OUT"],
        criterio:  row["CRITERIO"],
        evolucao:  row["EVOLUCAO"].to_i,
        dt_evoluca:  row["DT_EVOLUCA"].blank? ? row["DT_EVOLUCA"] : Date.strptime(row["DT_EVOLUCA"], '%d/%m/%Y'),
        dt_encerra:  row["DT_ENCERRA"].blank? ? row["DT_ENCERRA"] : Date.strptime(row["DT_ENCERRA"], '%d/%m/%Y'),
        dt_digita:  row["DT_DIGITA"].blank? ? row["DT_DIGITA"] : Date.strptime(row["DT_DIGITA"], '%d/%m/%Y'),
        histo_vgm:  row["HISTO_VGM"],
        pais_vgm:  row["PAIS_VGM"],
        co_ps_vgm:  row["CO_PS_VGM"],
        lo_ps_vgm:  row["LO_PS_VGM"],
        dt_vgm:  row["DT_VGM"].blank? ? row["DT_VGM"] : Date.strptime(row["DT_VGM"], '%d/%m/%Y'),
        dt_rt_vgm:  row["DT_RT_VGM"].blank? ? row["DT_RT_VGM"] : Date.strptime(row["DT_RT_VGM"], '%d/%m/%Y'),
        pcr_sars2:  row["PCR_SARS2"],
        pac_cocbo:  row["PAC_COCBO"],
        pac_dscbo:  row["PAC_DSCBO"],
        out_anim:  row["OUT_ANIM"],
        dor_abd:  row["DOR_ABD"],
        fadiga:  row["FADIGA"],
        perd_olft:  row["PERD_OLFT"],
        perd_pala:  row["PERD_PALA"],
        tomo_res:  row["TOMO_RES"],
        tomo_out:  row["TOMO_OUT"],
        dt_tomo:  row["DT_TOMO"].blank? ? row["DT_TOMO"] : Date.strptime(row["DT_TOMO"], '%d/%m/%Y'),
        tp_tes_an:  row["TP_TES_AN"],
        dt_res_an:  row["DT_RES_AN"].blank? ? row["DT_RES_AN"] : Date.strptime(row["DT_RES_AN"], '%d/%m/%Y'),
        res_an:  row["RES_AN"],
        pos_an_flu:  row["POS_AN_FLU"],
        tp_flu_an:  row["TP_FLU_AN"],
        pos_an_out:  row["POS_AN_OUT"],
        an_sars2:  row["AN_SARS2"],
        an_vsr:  row["AN_VSR"],
        an_para1:  row["AN_PARA1"],
        an_para2:  row["AN_PARA2"],
        an_para3:  row["AN_PARA3"],
        an_adeno:  row["AN_ADENO"],
        an_outro:  row["AN_OUTRO"],
        ds_an_out:  row["DS_AN_OUT"],
        tp_am_sor:  row["TP_AM_SOR"],
        sor_out:  row["SOR_OUT"],
        dt_co_sor:  row["DT_CO_SOR"].blank? ? row["DT_CO_SOR"] : Date.strptime(row["DT_CO_SOR"], '%d/%m/%Y'),
        tp_sor:  row["TP_SOR"],
        out_sor:  row["OUT_SOR"],
        dt_res:  row["DT_RES"].blank? ? row["DT_RES"] : Date.strptime(row["DT_RES"], '%d/%m/%Y'),
        res_igg:  row["RES_IGG"],
        res_igm:  row["RES_IGM"],
        res_iga:  row["RES_IGA"],
        estrang:  row["ESTRANG"],
        vacina_cov:  row["VACINA_COV"].to_i,
        dose_1_cov:  row["DOSE_1_COV"].blank? ? row["DOSE_1_COV"] : Date.strptime(row["DOSE_1_COV"], '%d/%m/%Y'),
        dose_2_cov:  row["DOSE_2_COV"].blank? ? row["DOSE_2_COV"] : Date.strptime(row["DOSE_2_COV"], '%d/%m/%Y'),
        dose_ref:  row["DOSE_REF"].blank? ? row["DOSE_REF"] : Date.strptime(row["DOSE_REF"], '%d/%m/%Y'),
        fab_cov_1:  row["FAB_COV_1"],
        fab_cov_2:  row["FAB_COV_2"],
        fab_covref:  row["FAB_COVREF"],
        lote_ref:  row["LOTE_REF"],
        lab_pr_cov:  row["LAB_PR_COV"],
        lote_1_cov:  row["LOTE_1_COV"],
        lote_2_cov:  row["LOTE_2_COV"],
        fnt_in_cov:  row["FNT_IN_COV"].to_i,
      })

      if records.size == BATCH_SIZE then
        SragRecord.insert_all! records
        records = []
      end
    end

    if records.size > 0 then
      SragRecord.insert_all! records
    end

    srag.update! status: Srag::INGESTED, ingested: true
  ensure
    srag.update status: Srag::ERROR unless srag.status == Srag::INGESTED
  end


  def download(srag)
    return srag.local_path if srag.downloaded?


    logger.info("Downloading #{srag.url} to '#{srag.local_path}'")
    srag.update! status: Srag::DOWNLOADING
    src = URI.open(srag.url)
    IO.copy_stream(src, srag.local_path)

    srag.update! status: Srag::DOWNLOADED, downloaded: true

    return srag.local_path
  end

end
