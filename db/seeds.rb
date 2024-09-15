# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: 'admin@admin',
    password: '111111'
)

FeelingAfterReading.create!(
    name: '感動的'
)

FeelingAfterReading.create!(
    name: '楽しい'
)

FeelingAfterReading.create!(
    name: '悲しい'
)

FeelingAfterReading.create!(
    name: 'ワクワク'
)

FeelingAfterReading.create!(
    name: '怖い'
)

FeelingAfterReading.create!(
    name: 'ときめく'
)

FeelingAfterReading.create!(
    name: '爽快'
)

FeelingAfterReading.create!(
    name: 'モヤモヤする'
)

FeelingAfterReading.create!(
    name: '笑える'
)

FeelingAfterReading.create!(
    name: '実用的'
)

FeelingAfterReading.create!(
    name: '学びがある'
)

FeelingAfterReading.create!(
    name: '心動かす'
)
