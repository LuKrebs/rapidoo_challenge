require 'test_helper'

class ClientTest < ActionDispatch::IntegrationTest
  test "for a client with a revenue between 50k and 100k, return the correct value of the asset with descount and the total fee applied" do
    client = Client.create(monthly_revenue: "75000", asset_value: "1500", due_date: Time.now.to_date + 123.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1178.25")
    assert page.has_content?("Taxa final: 21.45%")
    assert page.has_content?("Prazo do título, em dias: 123")

    # Other client, with a different due_date
    client = Client.create(monthly_revenue: "75000", asset_value: "1500", due_date: Time.now.to_date + 28.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1425.75")
    assert page.has_content?("Taxa final: 4.95%")
    assert page.has_content?("Prazo do título, em dias: 28")
  end

  test "for a client with a monthly revenue smaller than 50k, return the correct value of the asset with descount and the total fee applied" do
    client = Client.create(monthly_revenue: "45000", asset_value: "1500", due_date: Time.now.to_date + 123.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1149.0")
    assert page.has_content?("Taxa final: 23.4%")
    assert page.has_content?("Prazo do título, em dias: 123")

    client = Client.create(monthly_revenue: "45000", asset_value: "1500", due_date: Time.now.to_date + 28.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1419.0")
    assert page.has_content?("Taxa final: 5.4%")
    assert page.has_content?("Prazo do título, em dias: 28")
  end

  test "for a client with a monthly revenue greater than 100k, return the correct value of the asset with descount and the total fee applied" do
    client = Client.create(monthly_revenue: "110000", asset_value: "1500", due_date: Time.now.to_date + 123.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1207.5")
    assert page.has_content?("Taxa final: 19.5%")
    assert page.has_content?("Prazo do título, em dias: 123")

    client = Client.create(monthly_revenue: "110000", asset_value: "1500", due_date: Time.now.to_date + 28.days)

    visit "/clients/#{client.id}"

    assert_equal client_path(Client.last.id), page.current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Valor do título com desconto: R$ 1432.5")
    assert page.has_content?("Taxa final: 4.5%")
    assert page.has_content?("Prazo do título, em dias: 28")
  end
end
