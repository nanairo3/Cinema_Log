class MovieInfomationPeriodicallyImportBatch
  def self.exec
    MoviesAcquisitionApiSercvice.api_execution
  end
end