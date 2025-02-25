class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, inclusion: { in: [true, false] }

  enum :status, { task_new: 'new', in_progress: 'in_progress', completed: 'completed' }
end
