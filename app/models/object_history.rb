class ObjectHistory < ActiveRecord::Base
  belongs_to :object, polymorphic: true
  validates_presence_of :object, :reference, :key, :value
end