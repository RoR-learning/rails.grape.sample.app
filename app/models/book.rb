class Book < ApplicationRecord
  belongs_to :publisher
  has_and_belongs_to_many :categories

  def as_json(options = {})
    super(
        include: {
            publisher: {only: [:name]},
            categories: {only: [:id, :name]}
        }
    )
  end
end
