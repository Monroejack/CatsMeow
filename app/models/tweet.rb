class Tweet < ApplicationRecord

  before_validation :link_check, on: :create

  belongs_to :user
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  validates :message, presence: true
  validates :message, length: {maximum: 281,
  too_long: "Meowwww...you can only go one character above twitter: 281"}, on: :create

  after_validation :apply_link, on: :create
  private

  def apply_link
    arr = self.message.split
    index = arr.map{ |x| x.include? "http" }.index(true)

    if index
      url = arr[index]
      arr[index] = "<a href='#{self.link}' target='_blank'>#{url}</a>"
    end

    self.message = arr.join ' '
  end

  def link_check
    check = false
    if self.message.include? 'http://'
      check = true
    elsif
    self.message.include? 'https://'
    end

    if check
      arr = self.message.split
      index = arr.map{ |x| x.include? "http"}.index(true)
        self.link = arr[index]
        if arr[index].length > 23
    	    arr[index] = "#{arr[index][0..20]}..."
        end

        self.message = arr.join " "
    end
  end
end
