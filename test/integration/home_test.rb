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

  test "If the due date is the current date, should render the root page with athe appropriated error message" do
    current_day = Time.now.to_date.day.to_s
    current_month = Date::MONTHNAMES[Time.now.to_date.month]
    current_year = Time.now.to_date.year.to_s


    visit "/"

    fill_in "Faturamento mensal aproximado", with: "75000"
    fill_in "Valor do título (valor mínimo de R$ 500,00)", with: "1500"
    select(current_day, :from => 'client_due_date_3i')
    select(current_month, :from => 'client_due_date_2i')
    select(current_year, :from => 'client_due_date_1i')
    click_button "Simular"

    assert_equal 200, page.status_code
    assert_equal clients_path, page.current_path
    assert page.has_content?('O prazo mínimo de vencimento do título deve ser de 10 dias')
  end

  test "If the due date of an asset is smaller than 10 days, should render the root page with the appropriated error message" do
    visit "/"

    current_date_plus_eight = Time.now.to_date + 8.days

    fill_in "Faturamento mensal aproximado", with: "75000"
    fill_in "Valor do título (valor mínimo de R$ 500,00)", with: "1500"
    select(current_date_plus_eight.day, :from => 'client_due_date_3i')
    select(Date::MONTHNAMES[current_date_plus_eight.month], :from => 'client_due_date_2i')
    select(current_date_plus_eight.year, :from => 'client_due_date_1i')
    click_button "Simular"

    assert_equal 200, page.status_code
    assert_equal clients_path, page.current_path
    assert page.has_content?('O prazo mínimo de vencimento do título deve ser de 10 dias')
  end

  test "If the value of the asset is smaller than R$ 500, should render the root page with the appropriated error message " do
    visit "/"

    current_date_plus_ten_days = Time.now.to_date + 10.days

    fill_in "Faturamento mensal aproximado", with: "75000"
    fill_in "Valor do título (valor mínimo de R$ 500,00)", with: "499"
    select(current_date_plus_ten_days.day, :from => 'client_due_date_3i')
    select(Date::MONTHNAMES[current_date_plus_ten_days.month], :from => 'client_due_date_2i')
    select(current_date_plus_ten_days.year, :from => 'client_due_date_1i')
    click_button "Simular"

    assert_equal 200, page.status_code
    assert_equal clients_path, page.current_path
    assert page.has_content?('O valor do título deve ser acima de R$ 500,00')
  end
end
