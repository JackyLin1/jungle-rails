require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Add to Cart" do
    visit root_path
    expect(page).to have_css 'article.product', count: 10

    click_on 'Add'
    
    expect(page).to have_content("My Cart (1)")
    save_and_open_screenshot
  end
end