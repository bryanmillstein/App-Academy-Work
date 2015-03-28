class Cat < ActiveRecord::Base
  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    :description,
    :user_id,
    presence: true
  )
  validates(
    :sex,
    inclusion: { in: ["M", "F"], message: "Sex must be 'M' or 'F'" }
  )
  validates(
    :color,
    inclusion: { in: ['Black', 'White', 'Brown', 'Orange'],
      message: "Color must be a valid color." }
  )

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )


  def age
    age = Date.today.year - self.birth_date.year
    months = Date.today.month - self.birth_date.month
    days = Date.today.day - self.birth_date.day
    if months < 0
      age -= 1
    elsif months == 0
      if days < 0
        age -= 1
      end
    end

    age
  end

end
