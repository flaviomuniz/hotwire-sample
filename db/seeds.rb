Language.destroy_all
Employee.destroy_all

20.times do
  Language.create(
    name: Faker::ProgrammingLanguage.name
  )
end

1000.times do
  Employee.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    status: Faker::Boolean.boolean,
    language_id: Language.all.sample.id
  )
end
