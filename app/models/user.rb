# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  first_name             :string(70)
#  last_name              :string(70)
#  phone                  :string(70)
#  skype                  :string(70)
#  nickname               :string(255)
#  uid                    :string(255)
#  provider               :string(255)
#  image                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  ban                    :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :upload_files, :as => :fileable
  accepts_nested_attributes_for :upload_files, :comments

end
