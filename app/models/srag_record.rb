class SragRecord < ApplicationRecord
  belongs_to :srag

  def vaccinated?
    vacina_cov == 1 or dose_1_cov.present? or dose_2_cov.present? or dose_ref.present?
  end

  def fully_vaccinated?
    dose_2_cov.present? or dose_ref.present?
  end

  def unvaccinated?
    vacina_cov == 2
  end

  def pfizer?
    if fab_covref.present? then
      return (fab_covref.downcase.include? 'pfi' or
        fab_covref.downcase.include? 'pfa' or
        fab_covref.downcase.include? 'pfz')
    elsif fab_cov_2.present? then
      return (fab_cov_2.downcase.include? 'pfi' or
        fab_cov_2.downcase.include? 'pfa' or
        fab_cov_2.downcase.include? 'pfz')
    elsif fab_cov_1.present? then
      return (fab_cov_1.downcase.include? 'pfi' or
        fab_cov_1.downcase.include? 'pfa' or
        fab_cov_1.downcase.include? 'pfz')
    else
      return false
    end
  end

  def janssen?
    if fab_covref.present? then
      return fab_covref.downcase.include? 'jans'
    elsif fab_cov_2.present? then
      return fab_cov_2.downcase.include? 'jans'
    elsif fab_cov_1.present? then
      return fab_cov_1.downcase.include? 'jans'
    else
      return false
    end
  end

  def coronavac?
    if fab_covref.present? then
      return (fab_covref.downcase.include? 'coronav' or
        fab_covref.downcase.include? 'butan' or
        fab_covref.downcase.include? 'sinov')
    elsif fab_cov_2.present? then
      return (fab_cov_2.downcase.include? 'coronav' or
        fab_cov_2.downcase.include? 'butan' or
        fab_cov_2.downcase.include? 'sinov')
    elsif fab_cov_1.present? then
      return (fab_cov_1.downcase.include? 'coronav' or
        fab_cov_1.downcase.include? 'butan' or
        fab_cov_1.downcase.include? 'sinov')
    else
      return false
    end
  end

  def astrazeneca?
    if fab_covref.present? then
      return (fab_covref.downcase.include? 'astraz' or
        fab_covref.downcase.include? 'aztra' or
        fab_covref.downcase.include? 'astras' or
        fab_covref.downcase.include? 'oxfor' or
        fab_covref.downcase.include? 'cruz')
    elsif fab_cov_2.present? then
      return (fab_cov_2.downcase.include? 'astraz' or
        fab_covref.downcase.include? 'aztra' or
        fab_covref.downcase.include? 'astras' or
        fab_covref.downcase.include? 'oxfor' or
        fab_covref.downcase.include? 'cruz')
    elsif fab_cov_1.present? then
      return (fab_cov_1.downcase.include? 'astraz' or
        fab_covref.downcase.include? 'aztra' or
        fab_covref.downcase.include? 'astras' or
        fab_covref.downcase.include? 'oxfor' or
        fab_covref.downcase.include? 'cruz')
    else
      return false
    end
  end

end
