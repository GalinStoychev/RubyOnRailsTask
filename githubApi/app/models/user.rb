class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String

  embeds_many :repositories
end