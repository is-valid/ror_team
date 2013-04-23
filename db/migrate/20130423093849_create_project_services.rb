class CreateProjectServices < ActiveRecord::Migration
  def change
    create_table :project_services do |t|
      t.integer :project_id
      t.integer :service_id

      t.timestamps
    end
  end
end
