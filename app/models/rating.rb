class Rating < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :resource, polymorphic: true
end
