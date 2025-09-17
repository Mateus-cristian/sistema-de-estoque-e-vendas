# frozen_string_literal: true

class ChangeRoleInUsers < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      UPDATE users SET role = '0' WHERE role = 'user';
      UPDATE users SET role = '1' WHERE role = 'admin';
    SQL

    execute <<-SQL
      ALTER TABLE users
      ALTER COLUMN role TYPE integer USING role::integer,
      ALTER COLUMN role SET DEFAULT 0,
      ALTER COLUMN role SET NOT NULL;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE users SET role = 'user' WHERE role = 0;
      UPDATE users SET role = 'admin' WHERE role = 1;
    SQL

    change_column :users, :role, :string, default: "0", null: false
  end
end
