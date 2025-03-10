class RenameStateToAasmStateInVacancies < ActiveRecord::Migration[7.2]
  def change
    rename_column :vacancies, :state, :aasm_state
  end
end
