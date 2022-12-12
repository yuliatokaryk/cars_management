# frozen_string_literal: true

# Application Record model
class ApplicationRecord
  def initialize(db_name)
    @db_name = db_name
  end

  def all
    data_list
  end

  private

  def database
    Database.new(@db_name)
  end

  def data_list
    database.fetch
  end

  def update_db(updated_data)
    database.update(updated_data)
  end
end
