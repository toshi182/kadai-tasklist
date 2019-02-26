class AddUserToTasks < ActiveRecord::Migration[5.0]
  def change
    # tasksテーブルに対して、usersを参照する外部キーである、user_idを追加する
    add_reference :tasks, :user, foreign_key: true
  end
end
