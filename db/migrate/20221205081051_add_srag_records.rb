class AddSragRecords < ActiveRecord::Migration[7.0]
  def up
    # Source https://opendatasus.saude.gov.br
    Srag.create!([
      {
        year: 2021,
        release_date: '2022-12-08',
        url: 'https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SRAG/2021/INFLUD21-15-08-2022.csv'
      },
      {
        year: 2022,
        release_date: '2022-11-28',
        url: 'https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SRAG/2022/INFLUD22-28-11-2022.csv'
      }
    ])

  end
end
