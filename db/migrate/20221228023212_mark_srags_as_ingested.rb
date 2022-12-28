class MarkSragsAsIngested < ActiveRecord::Migration[7.0]
  def up
    Srag.where(status: [ Srag::INGESTED, Srag::REPORT_DONE, Srag::GEN_REPORT, Srag::REPORT_ERROR ]).update_all(ingested: true)
  end
end
