require 'json'
require 'date'

class Task
  attr_accessor :id, :title, :deadline, :status

  def initialize(id, title, deadline, status = 'not completed')
    @id = id
    @title = title
    @deadline = Date.parse(deadline)
    @status = status
  end

  def to_hash
    { id: @id, title: @title, deadline: @deadline.to_s, status: @status }
  end
end

class TaskManager
  FILE_PATH = 'tasks.json'

  def initialize
    @tasks = load_tasks
  end

  def task_exists?(id)
    @tasks.any? { |task| task.id == id }
  end

  def add_task(title, deadline)
    id = @tasks.empty? ? 1 : @tasks.max_by(&:id).id + 1
    task = Task.new(id, title, deadline)
    @tasks << task
    save_tasks
  end

  def delete_task(id)
    @tasks.reject! { |task| task.id == id }
    save_tasks
  end

  def edit_task(id, title: nil, deadline: nil, status: nil)
    task = @tasks.find { |t| t.id == id }
    return unless task

    task.title = title if title
    task.deadline = Date.parse(deadline) if deadline
    task.status = status if status
    save_tasks
  end

  def filter_tasks(status: nil, before_date: nil, after_date: nil)
    filtered_tasks = @tasks.dup

    filtered_tasks.select! { |task| task.status == status } if status

    before_date = Date.parse(before_date) if before_date
    after_date = Date.parse(after_date) if after_date

    if before_date && after_date
      filtered_tasks.select! { |task| task.deadline >= after_date && task.deadline <= before_date }
    elsif before_date
      filtered_tasks.select! { |task| task.deadline <= before_date }
    elsif after_date
      filtered_tasks.select! { |task| task.deadline >= after_date }
    end

    filtered_tasks
  end

  private

  def load_tasks
    return [] unless File.exist?(FILE_PATH)

    JSON.parse(File.read(FILE_PATH), symbolize_names: true).map do |task_data|
      Task.new(task_data[:id], task_data[:title], task_data[:deadline], task_data[:status])
    end
  end

  def save_tasks
    File.write(FILE_PATH, JSON.pretty_generate(@tasks.map(&:to_hash)))
  end
end

def valid_number?(input)
  input.match?(/^\d+$/)
end

def valid_date_format?(date_str)
  date_str = date_str.tr('.', '-').tr('/', '-')
  Date.strptime(date_str, '%Y-%m-%d')
  true
rescue ArgumentError
  false
end

def run_task_manager
  manager = TaskManager.new

  loop do
    puts "\nTask Manager:"
    puts '1. Add Task'
    puts '2. Delete Task'
    puts '3. Edit Task'
    puts '4. Filter Tasks'
    puts '5. Exit'
    print "\nChoose an option: "
    choice = gets.to_i

    case choice
    when 1
      print 'Enter task title: '
      title = gets.chomp
      print 'Enter deadline (YYYY-MM-DD): '
      deadline = gets.chomp

      if valid_date_format?(deadline)
        manager.add_task(title, deadline)
        puts 'Task added successfully.'
      else
        puts 'Invalid date format. Please use YYYY-MM-DD.'
      end

    when 2
      print 'Enter task ID to delete: '
      id = gets.chomp

      if valid_number?(id)
        id = id.to_i
        if manager.task_exists?(id)
          manager.delete_task(id)
          puts 'Task deleted successfully.'
        else
          puts "No task found with ID #{id}."
        end
      else
        puts 'Please enter a valid numerical ID.'
      end

    when 3
      print "Enter task ID to edit: "
      id = gets.chomp

      if valid_number?(id)
        id = id.to_i
        if manager.task_exists?(id)
          print "Enter new title (or press Enter to skip): "
          title = gets.chomp
          print "Enter new deadline (YYYY-MM-DD or press Enter to skip): "
          deadline = gets.chomp
          print "Enter new status ('c' for completed, 'nc' for not completed or press Enter to skip): "
          status = gets.chomp

          if deadline.empty? || valid_date_format?(deadline)
            if status.empty? || %w[c nc].include?(status)
              status = status == 'c' ? 'completed' : 'not completed' unless status.empty?
              manager.edit_task(id, title: title.empty? ? nil : title, deadline: deadline.empty? ? nil : deadline, status: status.empty? ? nil : status)
              puts "Task updated successfully."
            else
              puts "Invalid status. Use 'c' for completed or 'nc' for not completed."
            end
          else
            puts "Invalid date format. Please use YYYY-MM-DD."
          end
        else
          puts "No task found with ID #{id}."
        end
      else
        puts "Please enter a valid numerical ID."
      end

    when 4
      print 'Enter status to filter (completed/not completed or press Enter to skip): '
      status = gets.chomp
      print 'Enter deadline before date (YYYY-MM-DD or press Enter to skip): '
      before_date = gets.chomp
      print 'Enter deadline after date (YYYY-MM-DD or press Enter to skip): '
      after_date = gets.chomp

      if (before_date.empty? || valid_date_format?(before_date)) && (after_date.empty? || valid_date_format?(after_date))
        tasks = manager.filter_tasks(
          status: status.empty? ? nil : status,
          before_date: before_date.empty? ? nil : before_date,
          after_date: after_date.empty? ? nil : after_date
        )
        tasks.each do |task|
          puts "ID: #{task.id}, Title: #{task.title}, Deadline: #{task.deadline}, Status: #{task.status}"
        end
      else
        puts 'Invalid date format for filtering. Please use YYYY-MM-DD.'
      end

    when 5
      puts 'Exiting...'
      break

    else
      puts 'Invalid option. Please try again.'
    end
  end
end

run_task_manager
