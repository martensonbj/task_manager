require 'models/task_manager'

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  # read all the tasks
  get '/tasks' do
    @tasks = TaskManager.all
    erb :index
  end

  # first step of create (show form)
  get '/tasks/new' do
    erb :new
  end

  # create (submit form data)
  post '/tasks' do
    TaskManager.create(params[:task])
    redirect '/tasks'
  end

  # read one specific task
  get '/tasks/:id' do |id|
    @task = TaskManager.find(id.to_i)
    erb :show
  end

  #update task
  get '/tasks/:id/edit' do |id|
    @task = TaskManager.find(id.to_i)
    erb :edit
  end

  put '/tasks/:id' do |id|
    TaskManager.update(id.to_i, params[:task])
    #tasks comes in as hash {task =>{title: some title, descripton:somedescription}}
    redirect "/tasks/#{id}"
  end

  not_found do
    erb :error
  end
end
