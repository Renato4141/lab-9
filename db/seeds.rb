Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Owner.destroy_all
Vet.destroy_all
User.destroy_all

admin_user = User.create!(email: "admin@vetclinic.com", password: "password", role: :admin)

vet_user1 = User.create!(email: "anabela@vet.com", password: "password", role: :vet)
vet_user2 = User.create!(email: "cabracobra@vet.com", password: "password", role: :vet)

owner_user1 = User.create!(email: "bancodetitirilquen@gmail.com", password: "password", role: :owner)
owner_user2 = User.create!(email: "juaninjh@gmail.com", password: "password", role: :owner)
owner_user3 = User.create!(email: "mhugo@gmail.com", password: "password", role: :owner)

owner1 = Owner.create!(first_name: "Juan Carlos", last_name: "Bodoque",
                       email: "bancodetitirilquen@gmail.com", phone: "458674",
                       address: "Titirilkquen 4", user: owner_user1)

owner2 = Owner.create!(first_name: "Juanin Juan", last_name: "Harry",
                       email: "juaninjh@gmail.com", phone: "654321",
                       address: "Isla de Cachirula", user: owner_user2)

owner3 = Owner.create!(first_name: "Mario", last_name: "Hugo",
                       email: "mhugo@gmail.com", phone: "987654",
                       address: "Esquina Ministro Carvajal", user: owner_user3)

owner4 = Owner.create!(first_name: "Tulio", last_name: "Triviño",
                       email: "tulio@31minutos.com", phone: "777777",
                       address: "Canal 31")


pet1 = owner1.pets.create!(name: "Estalagtimitiquita", species: "dog",  breed: "Labrador", date_of_birth: "2020-01-01", weight: 25.5)
pet2 = owner1.pets.create!(name: "Carambolas",         species: "cat",  breed: "Siamese",  date_of_birth: "2020-05-10", weight: 5.2)
pet3 = owner2.pets.create!(name: "Barney",             species: "rabbit", breed: "Mini Lop", date_of_birth: "2020-03-15", weight: 2.1)
pet4 = owner3.pets.create!(name: "Gonzo",              species: "dog",  breed: "Bulldog",  date_of_birth: "2020-07-20", weight: 20.0)
pet5 = owner2.pets.create!(name: "Lunares",            species: "cat",  breed: "Persian",  date_of_birth: "2020-11-11", weight: 4.8)
pet6 = owner4.pets.create!(name: "Bodokino",           species: "dog",  breed: "Poodle",   date_of_birth: "2021-02-14", weight: 8.0)

def attach_photo(pet, filename)
  path = Rails.root.join("db/seeds/pets", filename)
  file = File.open(path, "rb")
  pet.photo.attach(io: file, filename: filename, content_type: "image/jpeg")
  file.close
end

attach_photo(pet1, "Perro1.jpg")
attach_photo(pet2, "Gato1.jpg")
attach_photo(pet3, "Conejo1.jpg")


vet1 = Vet.create!(first_name: "Anabela", last_name: "Silvanus",
                   email: "anabela@vet.com", phone: "111111",
                   specialization: "General", user: vet_user1)

vet2 = Vet.create!(first_name: "Cabro", last_name: "Cabreras",
                   email: "cabracobra@vet.com", phone: "222222",
                   specialization: "Surgery", user: vet_user2)


vet3 = Vet.create!(first_name: "Patana", last_name: "Tufillo",
                   email: "patana@vet.com", phone: "333333",
                   specialization: "Dentistry")


app1 = Appointment.create!(pet: pet1, vet: vet1, date: 3.days.from_now, reason: "Checkup",    status: 0)
app2 = Appointment.create!(pet: pet2, vet: vet1, date: 1.day.from_now,  reason: "Vaccination", status: 1)
app5 = Appointment.create!(pet: pet5, vet: vet1, date: 1.day.ago,       reason: "Skin issue",  status: 3)


app3 = Appointment.create!(pet: pet3, vet: vet2, date: 2.days.ago,  reason: "Injury",  status: 2)
app4 = Appointment.create!(pet: pet4, vet: vet2, date: 5.days.ago,  reason: "Surgery", status: 2)


app6 = Appointment.create!(pet: pet6, vet: vet3, date: 2.days.from_now, reason: "Cleaning", status: 0)


Treatment.create!(appointment: app2, name: "Antibiotic",     medication: "Amoxicillin", dosage: "2x daily", administered_at: Time.now, clinical_notes: "Infection")
Treatment.create!(appointment: app2, name: "Vitamin",        medication: "Vit C",       dosage: "1x daily", administered_at: Time.now, clinical_notes: "Immune boost")
Treatment.create!(appointment: app3, name: "Pain relief",    medication: "Ibuprofen",   dosage: "1x daily", administered_at: Time.now, clinical_notes: "Post injury")
Treatment.create!(appointment: app3, name: "Bandage",        medication: "None",        dosage: "N/A",      administered_at: Time.now, clinical_notes: "Wound care")
Treatment.create!(appointment: app4, name: "Post surgery",   medication: "Antibiotics", dosage: "3x daily", administered_at: Time.now, clinical_notes: "Recovery")
Treatment.create!(appointment: app6, name: "Dental cleaning", medication: "Anesthesia", dosage: "1x",       administered_at: Time.now, clinical_notes: "Routine")

puts "Seeded:"
puts "  #{User.count} users (1 admin, #{User.vet.count} vets, #{User.owner.count} owners)"
puts "  #{Owner.count} owners, #{Vet.count} vets"
puts "  #{Pet.count} pets, #{Appointment.count} appointments, #{Treatment.count} treatments"