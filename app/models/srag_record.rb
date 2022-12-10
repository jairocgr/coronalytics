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

end
