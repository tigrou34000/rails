if Rails.env.development?
  ENV['ROOT_URL_FRONT'] = 'http://localhost:8080'
  ENV['ROOT_URL_BACK'] =  'http://localhost:3000'
end