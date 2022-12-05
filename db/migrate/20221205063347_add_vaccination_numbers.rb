class AddVaccinationNumbers < ActiveRecord::Migration[7.0]
  def up

    # Source https://ourworldindata.org
    VaccinationNumber.create!([

      # Year 2021
      {country:'BRA', year:2021, month: 1, one_dose:  0.10, two_doses: 0    , boosted: 0     }, # JAN
      {country:'BRA', year:2021, month: 2, one_dose:  1.06, two_doses: 0    , boosted: 0     }, # FEB
      {country:'BRA', year:2021, month: 3, one_dose:  3.16, two_doses:  0.95, boosted: 0     }, # MAR
      {country:'BRA', year:2021, month: 4, one_dose:  8.66, two_doses:  2.43, boosted: 0     }, # APR
      {country:'BRA', year:2021, month: 5, one_dose: 14.78, two_doses:  7.35, boosted: 0     }, # MAY
      {country:'BRA', year:2021, month: 6, one_dose: 21.80, two_doses: 10.47, boosted: 0     }, # JUN
      {country:'BRA', year:2021, month: 7, one_dose: 35.43, two_doses: 12.52, boosted: 0     }, # JUL
      {country:'BRA', year:2021, month: 8, one_dose: 48.90, two_doses: 19.32, boosted: 0     }, # AUG
      {country:'BRA', year:2021, month: 9, one_dose: 63.66, two_doses: 29.61, boosted: 0     }, # SEP
      {country:'BRA', year:2021, month:10, one_dose: 70.55, two_doses: 43.08, boosted: 0     }, # OCT
      {country:'BRA', year:2021, month:11, one_dose: 74.14, two_doses: 54.01, boosted: 0     }, # NOV
      {country:'BRA', year:2021, month:12, one_dose: 76.24, two_doses: 62.53, boosted: 0     }, # DEZ

      # Year 2022
      {country:'BRA', year:2022, month: 1, one_dose: 77.19, two_doses: 66.62, boosted: 0     }, # JAN
      {country:'BRA', year:2022, month: 2, one_dose: 79.23, two_doses: 69.68, boosted: 0     }, # FEB
      {country:'BRA', year:2022, month: 3, one_dose: 82.59, two_doses: 72.02, boosted: 0     }, # MAR
      {country:'BRA', year:2022, month: 4, one_dose: 84.22, two_doses: 74.78, boosted: 0     }, # APR
      {country:'BRA', year:2022, month: 5, one_dose: 84.82, two_doses: 76.16, boosted: 0     }, # MAY
      {country:'BRA', year:2022, month: 6, one_dose: 85.42, two_doses: 77.17, boosted: 0     }, # JUN
      {country:'BRA', year:2022, month: 7, one_dose: 85.80, two_doses: 78.52, boosted: 0     }, # JUL
      {country:'BRA', year:2022, month: 8, one_dose: 86.31, two_doses: 79.34, boosted: 0     }, # AUG
      {country:'BRA', year:2022, month: 9, one_dose: 86.64, two_doses: 79.75, boosted: 0     }, # SEP
      {country:'BRA', year:2022, month:10, one_dose: 87.02, two_doses: 80.03, boosted: 0     }, # OCT
      {country:'BRA', year:2022, month:11, one_dose: 87.03, two_doses: 80.04, boosted: 0     }, # NOV
      {country:'BRA', year:2022, month:12, one_dose: 87.43, two_doses: 80.88, boosted: 0     }, # DEZ

    ])

  end
end
