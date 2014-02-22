# == Schema Information
#
# Table name: albums
#
#  id              :integer          not null, primary key
#  title           :string(255)      not null
#  band_id         :integer          not null
#  recording_style :string(255)      default("studio"), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Album < ActiveRecord::Base
  validates :title, :band_id, :presence => true
  validates :title, :uniqueness => true

  has_many :tracks, :dependent => :destroy
  belongs_to :band
end
