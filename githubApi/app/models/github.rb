class Github
  include HTTParty
  base_uri 'http://api.github.com'

  def initialize    
  end

  def repositories(username, options={})
   
    self.class.get("/users/#{username}/repos", :verify => false )
  end
end