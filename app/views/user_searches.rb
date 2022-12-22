# frozen_string_literal: true

# service to generate statistics show view
class UserSearches
  def show(results)
    puts I18n.t('user_searches.searches_title').colorize(:green)
    results.each do |result|
      create_search_table(result)
    end
  end

  def create_search_table(search_result)
    table = Terminal::Table.new title: search_result[0]['date'].colorize(:yellow) do |t|
      search_result[1..].each do |search|
        row = []
        search.each { |key, value| row << "#{key} : #{value}" }
        t << row
      end
      t.style = { all_separators: true }
    end
    puts table
  end
end