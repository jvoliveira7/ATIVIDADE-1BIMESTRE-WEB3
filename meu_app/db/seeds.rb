# db/seeds.rb

puts "Iniciando o processo de seed..."

# Limpa os dados existentes para evitar duplicatas
puts "Limpando dados de Usuários e Papéis..."
User.destroy_all
Role.destroy_all

# Cria os Papéis (Roles)
puts "Criando papéis (admin, moderator, student)..."
admin_role = Role.find_or_create_by!(title: "admin")
moderator_role = Role.find_or_create_by!(title: "moderator")
student_role = Role.find_or_create_by!(title: "student")
puts "Papéis criados com sucesso!"

# Cria os Usuários de Teste
puts "Criando usuários de teste..."

User.create!(
  name: "Administrador Fulano",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: admin_role
)

User.create!(
  name: "Moderador 1",
  email: "moderator@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: moderator_role
)

User.create!(
  name: "Estudante 1",
  email: "student@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: student_role
)

puts "Usuários de teste criados com sucesso!"
puts "Seed finalizado. ✨"