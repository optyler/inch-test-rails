require 'CSV'
require "awesome_print"

module Utils

  def self.dispatch_csv_data(import_class, csv_file)

    known_references = import_class.pluck(:reference)

    to_insert = []
    to_update = []

    CSV.foreach(csv_file, { headers: true, header_converters: :symbol }) do |row|
      if known_references.include? row[:reference]
        to_update << row.to_hash
      else
        to_insert << row.to_hash
      end
    end
    { csv_insert: to_insert, csv_update: to_update }
  end

  def self.import_generic(import_class, csv_file)

    dispatched = self.dispatch_csv_data(import_class, csv_file)

    # if references not already in database, create them all at once
    import_class.create(dispatched[:csv_insert])

    # for those that have already a reference, go ahead
    self.update_generic(import_class, dispatched[:csv_update])
  end

  def self.update_generic(import_class, to_update=[])
    to_update.each do |row|

      obj = import_class.find_in_history(row)
      if obj.any?
        known_keys = obj.first.object_history.map { |e| e.key.to_sym }
        csv_to_update = row.except(*known_keys)
        import_class.find_by_reference(csv_to_update[:reference]).update(csv_to_update)
      end
    end
  end

end
