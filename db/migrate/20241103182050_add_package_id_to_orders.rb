class AddPackageIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :package_id, :integer
    add_foreign_key :orders, :packages # Dodaj klucz obcy, aby zapewnić relację z tabelą packages
    add_index :orders, :package_id     # Opcjonalnie dodaj indeks dla szybszych zapytań
  end
end
