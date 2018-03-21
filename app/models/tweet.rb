class Tweet < ApplicationRecord
  belongs_to :user

  validates :message, presence: true
  validates :message, length: {maximum: 281,
  too_long: "Meowwww...you can only go one character above twitter: 281"}
end
