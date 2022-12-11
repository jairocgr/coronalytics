class AddNotaryRecords < ActiveRecord::Migration[7.0]
  def up
    # Source https://transparencia.registrocivil.org.br/registros
    NotaryRecord.create!([
      { year: 2015, deaths:  957875, pandemic_year: false },
      { year: 2016, deaths: 1076244, pandemic_year: false },
      { year: 2017, deaths: 1110758, pandemic_year: false },
      { year: 2018, deaths: 1222827, pandemic_year: false },
      { year: 2019, deaths: 1289889, pandemic_year: false },
      
      { year: 2020, deaths: 1483757, pandemic_year: true },
      { year: 2021, deaths: 1756060, pandemic_year: true },
      { year: 2022, deaths: 1389819, pandemic_year: true },
    ])
  end
end
