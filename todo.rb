class Todo < ActiveRecord::Base
  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def to_displayable_string
    "#{id}. [#{completed ? "X" : " "}] #{todo_text} #{due_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "Overdue\n"
    puts overdue.to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts due_today.to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.to_displayable_list
    puts "\n\n"
  end

  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
    Todo.find_by(id: todo_id).update(completed: true)
    Todo.find(todo_id)
  end
end
