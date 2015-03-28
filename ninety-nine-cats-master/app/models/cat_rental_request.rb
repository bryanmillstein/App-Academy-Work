class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED),
                                  message: "Status must be valid."}
  validate :overlapping_approved_requests
  after_initialize :set_pending

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def set_pending
    self.status ||= 'PENDING'
  end

  def approve!
    CatRentalRequest.transaction do
      self.update(status: "APPROVED")
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.update(status: 'DENIED')
  end

  def pending?
    self.status == "PENDING"
  end

  def overlapping_pending_requests
    results = overlapping_requests.where("status = 'PENDING'")
  end

  private



  def overlapping_requests
    results = CatRentalRequest.all.where(['id != :id
      AND :cat_id = cat_id
      AND ((start_date BETWEEN :start_date AND :end_date)
      OR (end_date BETWEEN :start_date AND :end_date)
      OR (:start_date BETWEEN start_date AND end_date)
      OR (:end_date BETWEEN start_date AND end_date))',

      id: self.id,
      cat_id: self.cat_id,
      start_date: self.start_date,
      end_date: self.end_date])

    results
  end

  def overlapping_approved_requests
    results = overlapping_requests.where("status = 'APPROVED'")

    unless results.empty?
      start_date = results.first.start_date
      end_date = results.first.end_date
      errors[:base] <<
      "This is an overlapping approved request for" +
      " #{start_date} to #{end_date}."
    end
  end
end
