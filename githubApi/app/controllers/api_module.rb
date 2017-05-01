module ApiModule
  extend ActiveSupport::Concern

    included do
        # class level code
        # before_filter ....
    end
  
    def create_user(username)
        result = get_top_five_repos(username)
        if (result[:is_success])
            repositories_to_add = map_repos(result[:data])
            user_from_db = User.new(username: username, repositories: repositories_to_add)

            if  (user_from_db.save)
                return {:is_success => true, :data => user_from_db}
            else
                return {:is_success => false}
            end
        else               
            return {:is_success => false}
        end
    end
    
    def get_user(username)
        user_from_db = User.find_by(username: username)
        seconds_diff = time_diff(user_from_db[:updated_at].to_i, Time.now.to_i)
        
        if (seconds_diff > 5 * 60 ) #more than 5 min
            result = get_top_five_repos(username)
            repositories_to_add = map_repos(result[:data])
            if (user_from_db.update_attributes!(repositories: repositories_to_add))
                return {:is_success => true, :data => user_from_db}
            else
                return {:is_success => false}
            end
        else #less than 5 min
            return {:is_success => true, :data => user_from_db}
        end
    end

    private
    
    def map_repos(repos)
        reposiotries_to_add = []
        repos.each do |repo|
            reposiotries_to_add.push(Repository.new(name: repo["name"], watchers: repo["watchers_count"], description: repo["description"], language: repo["language"]))
        end
    
      return reposiotries_to_add
    end

    def get_top_five_repos(username)
        github = Github.new()
        user_repos = github.repositories(username)
        begin
            data = user_repos.sort_by { |repo| repo["watchers_count"] }.reverse.take(5)
        rescue
            return {:is_success => false}
        else
            return {:is_success => true, :data => data}
        end
    end

    def time_diff(start_time, end_time)
      seconds_diff = (end_time - start_time)
      # puts seconds_diff
      return seconds_diff
    end
end