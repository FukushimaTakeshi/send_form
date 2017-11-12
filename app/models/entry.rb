class Entry
  include ActiveModel::Model
  include ValidatorHelper

  attr_accessor :name, :name_katakana, :tel, :email
  # コーリバックさせたいアクションを指定
  define_model_callbacks :save
  before_save { self.valid? }

  validates :name, presence: true, length: { maximum: 20 }, string_type: true
  VALID_KATAKANA_REGEX = /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/
  validates :name_katakana, presence: true,
                            format: { with: VALID_KATAKANA_REGEX, message: :not_a_katakana },
                            length: { maximum: 20 }
  validates :tel, presence: true, numericality: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, email: true

  def initialize(texts, params={})
    texts.each_with_index do |val, index|
      class_eval do
        attr_accessor :"free_text_#{index}"
        validates :"free_text_#{index}", length: { maximum: 5 }
      end
    end
    super(params)
  end

  # validate :validate_forms
  #
  # def validate_forms
  #   free_form.each do |form|
  #     return if form.valid?
  #
  #     form.errors.full_messages.each do |message|
  #       errors.add(:free_texts, message)
  #     end
  #     form.errors.clear
  #   end
  # end

  # validate  :free_form_validation
  #
  #  def free_form_validation
  #    free_form.each do |form|
  #      if form.free_texts.length > 10
  #        errors.add(:free_form, "コメントは10文字以内で入力して下さい。")
  #        errors.add(:free_texts, "コメントは10文字以内で入力して下さい。")
  #      end
  #    end
  #  end

  # def free_form_attributes=(attributes)
  #   @free_form ||= []
  #   attributes.each do |_, params|
  #     @free_form.push(FreeForm.new(params))
  #   end
  # end

  def save
    run_callbacks :save do
    end
  end

end
