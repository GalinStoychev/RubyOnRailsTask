class Repository

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :watchers, type: Integer
  field :description, type: String
  field :language, type: String

  embedded_in :users
end
