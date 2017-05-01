# RubyOnRailsTask
Interview task for Metrilo

The main idea of this task is to show your ability to learn new frameworks.
## The problem
Build a Ruby on Rails application that consumes the [Github API](https://developer.github.com/v3/) and stores it temporarily in a local MongoDB. 
The application should have the following API endpoint:

#### GET /api/:username/popular_repos
Returns the top 5 repositories for the user sorted by most watchers (watchers_count property in the github API) in the following JSON format:
```javascript
[
  {
    name: 'Funky repo',
    description: 'Hot stuff',
    watchers: 18,
    language: 'Ruby'
  },
  {
    name: 'Boring repo',
    description: 'Somewhat boring repository',
    watchers: 0,
    language: 'PHP'
  }
]
```
### MongoDB
Second part of this task is to store the results of these requests temporarily, so that we don't have to make a request to the Github api every time. Use the [Mongoid](https://github.com/mongodb/mongoid) gem (library) and store the results of the requests in Mongo for 5 minutes. This means that if the same request is made multiple times in a 5 minute period, only one request will be made to the Github API.

