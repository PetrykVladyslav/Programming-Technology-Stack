require 'minitest/autorun'
require_relative '../file_checker'

class FileCheckerTest < Minitest::Test
  def setup
    @test_directory = File.join(__dir__, "test_dir")
    Dir.mkdir(@test_directory) unless Dir.exist?(@test_directory)
    clear_test_directory
  end

  def clear_test_directory
    Dir.glob(File.join(@test_directory, "*")).each { |file| File.delete(file) }
  end

  def test_files_present
    File.write(File.join(@test_directory, "test1.txt"), "Test content")
    File.write(File.join(@test_directory, "test2.txt"), "Test content")

    checker = FileChecker.new(@test_directory, "txt")
    files = checker.check_files
    assert_equal 2, files.size
  end

  def test_files_absent
    checker = FileChecker.new(@test_directory, "txt")
    files = checker.check_files
    assert_equal 0, files.size
  end

  def test_different_extension
    File.write(File.join(@test_directory, "test1.md"), "Test content")

    checker = FileChecker.new(@test_directory, "txt")
    files = checker.check_files
    assert_equal 0, files.size
  end

  def test_different_present
    File.write(File.join(@test_directory, "test2.md"), "Test content")
    File.write(File.join(@test_directory, "test3.txt"), "Test content")
    File.write(File.join(@test_directory, "test4.docx"), "Test content")

    checker = FileChecker.new(@test_directory, "md")
    files = checker.check_files
    assert_equal 1, files.size
  end

  def test_invalid_extension
    checker = FileChecker.new(@test_directory, "123")
    assert_empty checker.check_files

    checker = FileChecker.new(@test_directory, "txt!")
    assert_empty checker.check_files

    checker = FileChecker.new(@test_directory, "t@xt")
    assert_empty checker.check_files
  end

  def test_empty_directory
    checker = FileChecker.new(@test_directory, "txt")
    assert_empty checker.check_files
  end

  def test_case_insensitive_extension
    File.write(File.join(@test_directory, "TEST1.TXT"), "Test content")
    checker = FileChecker.new(@test_directory, "txt")
    files = checker.check_files
    assert_equal 1, files.size
  end

  def test_empty_extension
    checker = FileChecker.new(@test_directory, " ")
    assert_empty checker.check_files
  end

  def test_files_without_extension
    File.write(File.join(@test_directory, "README"), "Test content")
    checker = FileChecker.new(@test_directory, "txt")
    files = checker.check_files
    assert_equal 0, files.size
  end
end