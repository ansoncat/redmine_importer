require 'fastercsv'

class ImportInProgress < ActiveRecord::Base
  unloadable
  belongs_to :user
  belongs_to :project
  
  def samples(sample_count)
    if @samples.nil?
      @samples = Array.new
      FasterCSV.new(csv_data, csv_options).each do |row|
        break if @samples.size >= sample_count
        @samples << row
      end
    end
    return @samples
  end
  
private
  
  def csv_options
    @csv_options ||= {
      :headers    => true,
      :encoding   => encoding,
      :quote_char => quote_char,
      :col_sep    => col_sep
    }
  end
end
