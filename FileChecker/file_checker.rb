class FileChecker
  def initialize(directory, file_extension)
    @directory = directory
    @file_extension = file_extension
    validate_extension
  end

  def check_files
    return [] unless @file_extension
    files = Dir.glob(File.join(@directory, "*.#{@file_extension}"))
    if files.empty?
      puts "Файли з розширенням .#{@file_extension} відсутні в директорії #{@directory}."
    else
      puts "Знайдено файли з розширенням .#{@file_extension} в директорії #{@directory}:"
      files.each { |file| puts " - #{File.basename(file)}" }
    end
    files
  end

  private

  def validate_extension
    unless @file_extension.match?(/\A[a-zA-Z]+\z/)
      puts "Попередження: некоректне розширення '#{@file_extension}', використання зупинено."
      @file_extension = nil
    end
  end
end

checker = FileChecker.new("C:/Users/Влад/Documents/My Codes CS-11/Ruby/FileCheck/filecheck", "rb")
checker.check_files
