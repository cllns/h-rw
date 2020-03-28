Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      string :email, null: false, unique: true
      string :username, null: false, unique: true
      string :bio
      string :image
      string :encrypted_password

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
