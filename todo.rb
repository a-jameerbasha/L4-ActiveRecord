class Todo < ActiveRecord::Base
  def overdue?
    due_date < Date.today
  end

  def due_today?
    due_date == Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def to_displayable_string
    "#{id}. [#{completed ? "X" : " "}] #{todo_text} #{due_date}"
  end

  def self.show_list
    todo_overdue_string = ["Overdue"]
    todo_due_today_string = ["\nDue Today"]
    todo_due_later_string = ["\nDue Later"]

    all.map { |todo|
      todo.overdue? ? todo_overdue_string.push(todo.to_displayable_string) :
        todo.due_today? ? todo_due_today_string.push(todo.to_displayable_string) :
        todo_due_later_string.push(todo.to_displayable_string)
    }
    puts "\nMy Todo-list\n\n#{todo_overdue_string.join("\n")}\n #{todo_due_today_string.join("\n")}\n #{todo_due_later_string.join("\n")}"
  end

  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: Date.today + new_todo[:due_in_days], completed: false)
  end

  def self.mark_as_complete(todo_id)
    Todo.find_by(id: todo_id).update(completed: true)
    Todo.find(todo_id)
  end
end
