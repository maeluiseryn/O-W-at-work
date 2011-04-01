ActionMailer::Base.delivery_method = :smtp

	ActionMailer::Base.smtp_settings = {
	:enable_starttls_auto => true,
	:address => 'smtp.gmail.com',
	:port => 587,
	:domain => "gmail.com",
	:user_name => 'n0st4lg1af0r1nf1n1ty@gmail.com',
	:password => 'maeluiseryn',
	:authentication => 'plain',
}
