class Url < ActiveRecord::Base
  validates :url, :format => URI::regexp(%w(http https))
  validates_uniqueness_of :url, :code
  validate :url_filled?, on: :create

  before_save :create_url_attributes

  def self.verify_code(code)
    redirect_url = where({ code: code }).first
    if redirect_url.present?
      redirect_url.increment!(:count)
      redirect_url.url
    else
      false
    end
  end

  private
  def url_filled?
    domain = ['skirt.dev', 'skirt.herokuapp.com']
    if domain.any? {|w| url[w]}
      errors[:name] << "can not be bar"
    end
  end

  def create_url_attributes
    if url.present? && url_changed?
      self.url   = url
      self.count = 0
      self.code  = Relation.get_code
    end
  end
end
