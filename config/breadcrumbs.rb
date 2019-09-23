
crumb :root do
  link "Home", root_path
end

crumb :users do
	link "mypage", users_path
	parent :root
end

crumb :show do
	link "商品詳細", item_path
	parent :root
end

crumb :all_category do
  link "カテゴリ一覧",category_index_path
  parent :root
end

crumb :category do |category|
	link "#{category}",category_item_path
	parent :all_category
end

# crumb :parents do |category|
# 	# binding.pry
# 	# link "#{category}", category_item_path(category)
# 	link "",category_item_path
# 	parent :items
# end
# crumb :middle do |m|
# 	link ""
# 	parent :parents
# 	end
# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
