class ContactShare < ActiveRecord::Base

  validates :user_id, :contact_id, presence: true
  validates(:user_id, :uniqueness => {:scope => :contact_id})
  validate :ids_in_the_database
  validate :not_shared_with_self

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
  )

  private
    def ids_in_the_database
      unless User.exists?(user_id) && Contact.exists?(contact_id)
        errors[:base] << "You can't reference non-existent IDs"
      end
    end

    def not_shared_with_self
      if user_id == Contact.find(contact_id).user_id
        errors[:base] << "You can't share with yourself"
      end
    end
end
