class RunApi
  def initialize
  end

  def self.exec
    rails runner ./app/services/get_movies.rb
  end
end