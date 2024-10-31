require 'rspec'
require_relative '../task_manager'

RSpec.describe TaskManager do
  let(:manager) { TaskManager.new }

  before(:each) do
    File.write(TaskManager::FILE_PATH, JSON.dump([]))
  end

  it 'adds a task' do
    manager.add_task('Test Task', '2024-12-31')
    expect(manager.filter_tasks.size).to eq(1)
  end

  it 'deletes a task' do
    manager.add_task('Test Task', '2024-12-31')
    task_id = manager.filter_tasks.first.id
    manager.delete_task(task_id)
    expect(manager.filter_tasks.size).to eq(0)
  end

  it 'edits a task' do
    manager.add_task('Test Task', '2024-12-31')
    task_id = manager.filter_tasks.first.id
    manager.edit_task(task_id, title: 'Updated Task', status: 'completed')
    task = manager.filter_tasks.first
    expect(task.title).to eq('Updated Task')
    expect(task.status).to eq('completed')
  end

  it 'filters tasks by status' do
    manager.add_task('Test Task 1', '2024-12-31')
    manager.add_task('Test Task 2', '2024-11-30', 'completed')
    completed_tasks = manager.filter_tasks(status: 'completed')
    expect(completed_tasks.size).to eq(1)
  end

  it 'saves tasks to JSON file' do
    manager.add_task('Task for Save Test', '2024-10-30')
    saved_tasks = JSON.parse(File.read(TaskManager::FILE_PATH), symbolize_names: true)
    expect(saved_tasks.size).to eq(1)
    expect(saved_tasks[0][:title]).to eq('Task for Save Test')
  end

  it 'loads tasks from JSON file' do
    File.write(TaskManager::FILE_PATH, JSON.pretty_generate([{ id: 1, title: 'Loaded Task', deadline: '2024-10-30', status: 'not completed' }]))
    loaded_manager = TaskManager.new
    expect(loaded_manager.filter_tasks.size).to eq(1)
    expect(loaded_manager.filter_tasks.first.title).to eq('Loaded Task')
  end
end