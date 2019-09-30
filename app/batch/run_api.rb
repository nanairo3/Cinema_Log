class RunApi
  def initialize
  end

  def exec
    rails runner ./app/services/get_movies.rb
  end
end