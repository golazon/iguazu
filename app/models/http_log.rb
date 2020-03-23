class HttpLog < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
