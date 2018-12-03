crumb :root do
  link "Dashboard", root_path
end

crumb :law_firms do
  link "Law Firms", law_firms_path
end

crumb :law_firm do |law_firm|
  link law_firm.name, law_firm_path(law_firm)
  parent :law_firms
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).