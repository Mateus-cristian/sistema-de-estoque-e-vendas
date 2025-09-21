# frozen_string_literal: true

if Rails.env.development?
	User.find_or_create_by!(email: 'user.admin@uorak.com') do |user|
		user.name = 'admin'
		user.password = '@123password'
		user.password_confirmation = '@123password'
		user.role = :admin
	end
	puts 'Usuário admin criado: user.admin@uorak.com / @123password'
end