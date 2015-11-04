# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Couch.destroy_all
Reserva.destroy_all
Foto.destroy_all

#------ USERS ---------#

juan = User.create!(
    id:'1',
    nombre:"Juan",
    apellido:"Pérez",
    fecnac:'12/03/1990',
    email:"juanperez@hotmail.com",
    telf:"542215678901",
    rol:'admin',
    password: "topsecret",
    password_confirmation: "topsecret"
    )

diego = User.create!(
    id:'2',
    nombre:"Diego",
    apellido:"García",
    fecnac:'22/07/1995',
    email:"diego_g@gmail.com",
    telf:"541142857203",
    rol:'normal',
    password: "diegotuman",
    password_confirmation: "diegotuman"
    )

andres = User.create(
    id:'3',
    nombre:"Andres",
    apellido:"Martinez",
    fecnac:'31/10/2000',
    email:"am2000@gmail.com",
    telf:"5422345782734",
    rol:'normal',
    password: "andresito4ever",
    password_confirmation: "andresito4ever"
    )

esteban = User.create(
    id:'4',
    nombre:"Pablo Esteban",
    apellido:"Bigotes",
    fecnac:'03/01/1989',
    email:"estebb@hotmail.com",
    telf:"542215891010",
    rol:'premium',
    password: "tebis1234",
    password_confirmation: "tebis1234"
    )

#----- COUCHES ---------#

Couch.create(
    id:'1',
    tipo: 'casa',
    ubicacion:"En medio de la nada",
    capacidad:'1',
    descripcion:"Hermosa casa, ideal para tener un momento de relax y tranquilidad. Tengo una habitación extra para alojar visitantes.",
    usuario_id:andres.id,
    reservado:false
    )

Couch.create(
    id:'2',
    tipo:'casa',
    ubicacion:"Encima de una palmera",
    capacidad:5,
    descripcion:"Casa avión. Cuenta con 1 baño, 2 habitaciones y 83 ventanas para disfrutar de una hermosa vista.",
    usuario_id:esteban.id,
    reservado:false
    )

Couch.create(
    id:'3',
    tipo:'casa',
    ubicacion:"En el centro de la avenida",
    capacidad:8,
    descripcion:"Original casa dada vuelta. Cuenta con 2 baños, living, wifi, y 4 habitaciones. ",
    usuario_id:juan.id,
    reservado:false
    )

Couch.create(
    id:'4',
    tipo: 'choza',
    ubicacion:"Selva misionera",
    capacidad:6,
    descripcion:"Acogedora choza en la selva misionera. Cuenta con capacidad para 6 personas. Se encuentra en una aldea, ideal para compartir momentos con la tribu.
No cuenta con ventanas.",
    usuario_id:diego.id,
    reservado:false
    )

Couch.create(
    id:'5',
    tipo:'departamento',
    ubicacion:"En el quinto piso de las torres mellizas",
    capacidad:4,
    descripcion:"Hermosa vista desde el balcón, baños amplios y con aire acondicionado",
    usuario_id:juan.id,
    reservado:false
    )

#---- FOTOS -----#

Foto.create(
    couch_id:'1',
    nombre:"/couches/c1.jpg")

Foto.create(
    couch_id:'2',
    nombre:"/couches/c2.jpg")

Foto.create(
    couch_id:'3',
    nombre:"/couches/c3.jpg")

Foto.create(
    couch_id:'4',
    nombre:"/couches/c4.jpg")

Foto.create(
    couch_id:'5',
    nombre:"/couches/c5.jpg")

