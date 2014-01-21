class Url < ActiveRecord::Base

  validates :url, :format => URI::regexp(%w(http https))
  validates_uniqueness_of :url, :code
  # validates :count, :numericality => true

  before_save :create_url_attributes

  def self.verifyCode(code)
    @redirect_url = Url.where(:code=> code)
    if not @redirect_url.nil?
      @redirect_url = @redirect_url.first
      @redirect_url.count +=1
      @redirect_url.save
      @redirect_url.url
    else
      root_path
    end
  end

  private
  def url_filled?
    !url.blank?
  end

  def create_url_attributes
    if url.present? && url_changed?
      self.url   = url
      self.count = 0
      self.code  = random_code
    end
  end

  def random_code
    while true
      random_code = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten.sample(5).join
      if not Url.where(:code=> random_code).nil?
        break
      end
    end
    random_code
  end
end
