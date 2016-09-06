require "awesome_print"

module Versionable
  extend ActiveSupport::Concern

  included do
  	has_many :object_history, as: :object
  	after_create :generate_an_entry_in_history_with_all_fields
    after_update :generate_an_entry_in_history_for_updated_fields
  end

  class_methods do

    def find_in_history(csv_row)
      where_clause = csv_row.slice(*self::VERSIONABLE)
      where_clause = where_clause.map { |key, value| "(key='#{key.to_s}' AND value='#{value}' )" }.join(' OR ')
      
      self.where(reference: csv_row[:reference])
          .includes(:object_history)
            .select([:key, :value])
            .where(where_clause)
              .references(:object_history)
    end

  end

  protected
  def generate_an_entry_in_history_for_updated_fields
    add_to_version = []
    self.class::VERSIONABLE.each { |versionable|
      add_to_version << { reference: self.reference, key: versionable, value: self.send(versionable) } if self.send( "#{versionable}_changed?" )
    }
    self.object_history.create(add_to_version) if add_to_version.any?
  end

  def generate_an_entry_in_history_with_all_fields
    add_to_version = self.class::VERSIONABLE.map { |versionable|
      { reference: self.reference, key: versionable, value: self.send(versionable) }
    }
    self.object_history.create(add_to_version)
  end

end