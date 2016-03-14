class Vote < ActiveRecord::Base
  belongs_to :joke

  def self.get_joke_ids_for_user_id(user_id)
    Vote.where(user_id: user_id).pluck(:joke_id).uniq
  end
end
