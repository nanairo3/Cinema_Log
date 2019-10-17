class MovieInfomationPeriodicallyImportBatch
  def self.exec
    GetMovies.api_execution
  end
end