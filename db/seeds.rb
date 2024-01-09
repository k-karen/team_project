# frozen_string_literal: true

# db/seeds.rb

require "faker"

# 一時的にユーザーを保存するための配列
users = []

# ユーザーの生成
20.times do
  user = User.create(
    email: Faker::Internet.unique.email(domain: "example.com"),
    password: "aiit-password",
    username: Faker::Internet.unique.username,
    age: rand(18..100),
    biography: Faker::Lorem.sentence,
  )
  user.activate!

  users << user

  # 各ユーザーに対して2つのルームを生成
  2.times do
    room = Room.create(name: Faker::Lorem.word)

    # 各ルームに20件のメッセージを追加
    20.times do
      Message.create(
        room: room,
        user: user,
        content: Faker::Lorem.sentence,
      )
    end
  end
end

# フレンドシップの作成
users.each do |user|
  # ユーザー以外のユーザーを選択
  possible_friends = users.reject { |u| u == user }

  # 10件のフレンドシップを作成
  possible_friends.sample(10).each do |friend|
    Friendship.create(user: user, friend: friend, status: :accepted)
  end
end
