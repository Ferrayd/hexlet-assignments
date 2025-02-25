require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = Task.create!(
      name: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      status: 'task_new',
      creator: Faker::Name.name,
      performer: Faker::Name.name,
      completed: false
    )
  end

  test 'должен получить index' do
    get tasks_url
    assert_response :success
  end

  test 'должен создать задачу' do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { name: 'Новая задача', status: 'task_new', creator: 'Автор', completed: false } }
    end
    assert_redirected_to task_url(Task.last)
  end

  test 'должен показать задачу' do
    get task_url(@task)
    assert_response :success
  end

  test 'должен обновить задачу' do
    patch task_url(@task), params: { task: { name: 'Обновленное название' } }
    assert_redirected_to task_url(@task)
    @task.reload
    assert_equal 'Обновленное название', @task.name
  end

  test 'должен удалить задачу' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end
    assert_redirected_to tasks_url
  end
end
