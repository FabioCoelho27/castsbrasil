module User::Gamefication
  extend ActiveSupport::Concern

  included do
    has_many :scores, dependent: :destroy, after_add: :update_level
    belongs_to :level
    after_create :assing_level
  end

  def total_score
    scores.sum(:value) || 0
  end

  def assing_level
    update_attributes!(level: Level.first_by_score(total_score))
  end

  def update_level(*)
    new_level = Level.first_by_score(total_score)
    if level_id != new_level.id
      assing_level
      if new_level.role
        add_role Role.find(new_level.role.id).name
      end
    end
  end
end
