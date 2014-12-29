class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :image

      t.references :document, index: true

      t.timestamps
    end
  end
end
