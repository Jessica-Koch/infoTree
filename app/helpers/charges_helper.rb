module ChargesHelper
  def pretty_amount(amount_in_cents)
    number_to_currency(amount_in_cents / 100)
  end

  def make_wikis_public(user)
    @user.wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
  end
end
