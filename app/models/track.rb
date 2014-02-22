# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  album_id   :integer          not null
#  track_type :string(255)      default("regular"), not null
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TRACK_TYPE = ["regular", "bonus"]

  validates :title, :album_id, :track_type, :presence => true
  validates :track_type, :inclusion => TRACK_TYPE

  belongs_to :album
  delegate :band, :to => :album
end
