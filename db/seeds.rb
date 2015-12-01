# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Couch.destroy_all
Reservation.destroy_all
Searching.destroy_all
Message.destroy_all
Payment.destroy_all
Qualification.destroy_all
Question.destroy_all
Foto.destroy_all
Tipoc.destroy_all

#----- Tipos de couch ------#

casa = Tipoc.find_or_create_by(tipo:"Casa");
depto = Tipoc.find_or_create_by(tipo:"Departamento");
choza = Tipoc.find_or_create_by(tipo:"Choza");
motorh = Tipoc.find_or_create_by(tipo:"Motorhome");
puts "Tipos - creados"

#------ USERS ---------#
userA = User.create!(
    nombre: "A",
    apellido: "A",
    fecnac:'01/01/1990',
    email:"a@a.com",
    rol:"normal",
    password:"123456",
    password_confirmation:"123456"
    )

marcelo = User.create!(
    nombre:"Marcelo",
    apellido:"Bufartanelo",
    fecnac:'12/03/1990',
    email:"marcelo@hotmail.com",
    telf:"542215678901",
    rol:'admin',
    pais:'Argentina',
    ciudad:'La Plata',
    password: "topsecret",
    password_confirmation: "topsecret",
    genero:'Masculino'
    )

angelica = User.create!(
    nombre:"Angélica",
    apellido:"Portacelutti",
    fecnac:'12/03/1990',
    email:"angelica@hotmail.com",
    telf:"542215678901",
    rol:'admin',
    pais:'Argentina',
    ciudad:'La Plata',
    password: "topsecret",
    password_confirmation: "topsecret",
    genero:'Femenino'
    )

diego = User.create!(
    nombre:"Diego",
    apellido:"García",
    fecnac:'22/07/1995',
    email:"diego_g@gmail.com",
    telf:"541142857203",
    rol:'normal',
    password: "diegotuman",
    password_confirmation: "diegotuman",
    genero:'Masculino'
    )

andres = User.create!(
    nombre:"Andres",
    apellido:"Martinez",
    fecnac:'31/10/1996',
    email:"am2000@gmail.com",
    telf:"5422345782734",
    rol:'normal',
    password: "andresito4ever",
    password_confirmation: "andresito4ever",
    genero:'Masculino'
    )

esteban = User.create!(
    nombre:"Pablo Esteban",
    apellido:"Bigotes",
    fecnac:'03/01/1989',
    email:"estebb@hotmail.com",
    telf:"542215891010",
    rol:'premium',
    password: "tebis1234",
    password_confirmation: "tebis1234",
    genero:'Masculino'
    )
puts "Users - creados"

#----- COUCHES ---------#

50.times { |c| Couch.create(tipo: casa.id, ubicacion: "Calle #{c}", capacidad:'1', descripcion:"Linda casa en calle #{c}", user_id:esteban.id, reservado:false)}

a = Couch.create(
    tipo: casa.id,
    ubicacion:"En medio de la nada",
    capacidad:'1',
    descripcion:"Hermosa casa, ideal para tener un momento de relax y tranquilidad. Tengo una habitación extra para alojar visitantes.",
    user_id:andres.id,
    reservado:false
    )

b = Couch.create(
    tipo:casa.id,
    ubicacion:"Encima de una palmera",
    capacidad:5,
    descripcion:"Casa avión. Cuenta con 1 baño, 2 habitaciones y 83 ventanas para disfrutar de una hermosa vista.",
    user_id:esteban.id,
    reservado:false
    )

c = Couch.create(
    tipo:casa.id,
    ubicacion:"En el centro de la avenida",
    capacidad:8,
    descripcion:"Original casa dada vuelta. Cuenta con 2 baños, living, wifi, y 4 habitaciones. ",
    user_id:marcelo.id,
    reservado:false
    )

d = Couch.create(
    tipo: choza.id,
    ubicacion:"Selva misionera",
    capacidad:6,
    descripcion:"Acogedora choza en la selva misionera. Cuenta con capacidad para 6 personas. Se encuentra en una aldea, ideal para compartir momentos con la tribu. No cuenta con ventanas.",
    user_id:diego.id,
    reservado:false
    )

e = Couch.create(
    tipo:depto.id,
    ubicacion:"En el quinto piso de las torres mellizas",
    capacidad:4,
    descripcion:"Hermosa vista desde el balcón, baños amplios y con aire acondicionado",
    user_id:marcelo.id,
    reservado:false
    )

puts "Couches - creados"
#----- RESERVAS ------#

Reservation.create(
    user_id: marcelo.id,
    couch_id: a.id,
    start_date: "26/11/2015",
    end_date: "15/12/2015",
    confirmed: false
    )

Reservation.create(
    user_id: marcelo.id,
    couch_id: b.id,
    start_date: "20/12/2015",
    end_date: "30/12/2015",
    confirmed: false
    )

Reservation.create(
    user_id: diego.id,
    couch_id: c.id,
    start_date: "27/11/2015",
    end_date: "05/12/2015",
    confirmed: false
    )

Reservation.create(
    user_id: andres.id,
    couch_id: d.id,
    start_date: "01/12/2015",
    end_date: "10/12/2015",
    confirmed: false
    )

Reservation.create(
    user_id: esteban.id,
    couch_id: d.id,
    start_date: "05/12/2015",
    end_date: "15/12/2015",
    confirmed: false
    )

puts "Reservas - creadas"

