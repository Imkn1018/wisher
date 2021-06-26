# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


    # --- ここから追加する

guest = User.create!(name: 'ゲスト', email: 'guestsample1@sample.com', password:"guestTaro")
  wish1 = guest.wishes.create!(
    wish_title: "芝犬を飼いたい",
    purpose: "一緒に外で遊びたい",
    span: "2024-11-23",
    memo: "どの犬種を飼おうかな",
    action:"お金を稼ぐ",
    wish_image: File.open("./app/assets/images/alvan-nee-brFsZ7qszSY-unsplash.jpg"),
  )
  wish2 = guest.wishes.create!(
    wish_title: "新作のショコラケーキを食べてみたい",
    purpose: "",
    span: "2021-11-23",
    memo: "どの犬種を飼おうかな",
    action:"お金を稼ぐ",
    wish_image: File.open("./app/assets/images/henry-be-_y5CCcYWTjU-unsplash.jpg"),
  )
  wish3 = guest.wishes.create!(
    wish_title: "モルディブに行きたい",
    purpose: "ハネムーンを",
    span: "2025-11-23",
    memo: "どうやっていけるのかな？",
    action:"お金を稼ぐ",
    wish_image: File.open("./app/assets/images/muhammadh-saamy-eZ4wE34FnWw-unsplash.jpg"),
  )
  wish4 = guest.wishes.create!(
    wish_title: "ニューヨークで一人旅がしたい",
    purpose: "新婚旅行",
    span: "2022-11-23",
    memo: "どうやっていけるのかな？",
    action:"ワクチンを打つ",
    wish_image: File.open("./app/assets/images/guilherme-stecanella-_dH-oQF9w-Y-unsplash.jpg"),
  )

wish3.complete_reviews.create!(
  review_title: "たくさんの魚と泳げた！",
  complete_image: "https://source.unsplash.com/yiafdaCeeZI",
  user_id: guest.id,
)

wish2.complete_reviews.create!(
  review_title: "一人で頂上に登れた！",
  complete_image: "https://source.unsplash.com/bH7kZ0yazB0",
  user_id: guest.id,
)
wish1.complete_reviews.create!(
  review_title: "愛する人と結婚することができました。",
  complete_image: "https://source.unsplash.com/N1CZNuM_Fd8",
  user_id: guest.id,
)
wish4.complete_reviews.create!(
  review_title: "みんなと美味しい食事ができた！",
  complete_image: "https://source.unsplash.com/E6HjQaB7UEA",
  user_id: guest.id,
)


