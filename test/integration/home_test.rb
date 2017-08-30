require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  test "loads correctly" do
    visit "/"
    assert_equal 200, page.status_code
    assert page.has_content?("simulação")
  end

  test "Home page should have the correct inputs form" do
    visit "/"

    fill_in "Nome", with: "Luciano"
    fill_in "Email", with: "lkrebs05@gmail.com"
    fill_in "Nome da empresa", with: "Luciano S.A"
    fill_in "Faturamento mensal aproximado", with: "75000"
    fill_in "Valor do título (valor mínimo de R$ 500,00)", with: "1500"
    select('31', :from => 'client_due_date_3i')
    select('December', :from => 'client_due_date_2i')
    select('2017', :from => 'client_due_date_1i')
  end
end
