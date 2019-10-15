class RunApi
  def initialize
  end

  def self.exec
    rails runner GetMovies.api_execution
  end
end