puts 'Cleaning database...'

Complaint.destroy_all
Response.destroy_all
CompaniesUser.destroy_all
Company.destroy_all
User.destroy_all

puts 'Creating users...'

# USER ADMIN
User.create!(
  username: 'cassiano.admin',
  email: 'cassiano@u-innova.com',
  password: 'admin123',
  password_confirmation: 'admin123',
  first_name: 'Cassiano',
  last_name: 'Admin',
  phone_number: '000-000-0000',
  address: Faker::Address.full_address,
  city: 'New York',
  state: 'NY',
  zip_code: '0000-000',
  admin: true,
)

User.create!(
  username: 'narumi.admin',
  email: 'narumi@u-innova.com',
  password: 'admin123',
  password_confirmation: 'admin123',
  first_name: 'Narumi',
  last_name: 'Admin',
  phone_number: '000-000-0000',
  address: Faker::Address.full_address,
  city: 'New York',
  state: 'NY',
  zip_code: '0000-000',
  admin: true,
)

# USER COM RECLAMACOES 

user_normal = User.create!(
  username: 'user_normal',
  email: 'user1@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'One',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
)

puts 'Normal users created!'
puts 'Creating company users...'

# COMPANY USERS 

user_company = User.create!(
  username: 'user_company1',
  email: 'user_company1@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User1',
  last_name: 'Company1',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: true,
)

user_company2 = User.create!(
  username: 'user_company2',
  email: 'user_company2@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User2',
  last_name: 'Company2',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: true,
)

company_users = [user_company, user_company2]

puts 'Users created!'

############################################################################################################

puts 'Creating TEST companies...'

company1 = Company.create!(
  company_name: 'Empresa Exemplo',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_website: 'www.reclamejp.com',
  company_contact_email: 'suporte@reclamejp.com',
  company_social_media: { facebook: 'https://www.facebook.com/profile.php?id=61565440495945', instagram: 'https://www.instagram.com/servicos_no_japao' },
  company_description: 'Este perfil é um exemplo de empresa.',
  company_contact_name: 'John Doe',
  company_category: Company::COMPANY_CATEGORY.sample
)

############################################################################################################
puts "deleting photos from companies..."

Company.find_each do |company|
  if company.company_logo.attached?
    company.company_logo.purge
    puts "Deleted logo for #{company.company_name}"
  end
  
  if company.company_banner.attached?
    company.company_banner.purge
    puts "Deleted banner for #{company.company_name}"
  end
end

puts "Creating company EMPREITEIRAS..."

kowa = Company.create!(
  company_name: 'Kowa Corporation ',
  company_address: 'Gunma-ken Isesaki-shi Yanagihara 15',
  company_city: 'Isesaki-shi ',
  company_prefecture: 'Gunma',
  company_zip_code: '372-0054',
  company_country: 'Japan',
  company_phone_number: '0270-21-8155',
  company_website: 'www.kowa-corp.com',
  company_social_media: { facebook: 'www.facebook.com/kowa.corp', instagram: 'www.instagram.com/kowacorporationbrasil/' },
  company_description: 'A Kowa, trabalha com recrutamento desde 1991. Oferecemos aos nossos colaboradores, financiamento de passagens aéreas, 
                        serviços e assistência, além de transporte e moradia. Recrutamos pessoas para diversos tipos de serviços em várias regiões do Japão. 
                        Se você tem preferência por alguma região ou por gosto pessoal , ajudamos a encontrar o serviço mais próximo ao seu perfil',
  company_contact_email: 'cadastro@kowa-corp.com',
  company_category: 'Empreiteiras'
)
# kowa.company_logo.purge if kowa.company_logo.attached?
# kowa.company_banner.purge if kowa.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725252341/reclame-jp/exlf1g56sv6oidvsvuyh.png')
# kowa.company_logo.attach(
#   io: logo, 
#   filename: 'kowa.jpg', 
#   content_type: 'image/jpg')

# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725252341/reclame-jp/uefum56zahy8cecdiy5k.jpg')
# kowa.company_banner.attach(
#   io: banner, 
#   filename: 'kowa.jpg', 
#   content_type: 'image/jpg')

fujiarte = Company.create!(
  company_name: 'Fujiarte',
  company_address: 'Taiyujicho, 5-15 Umeda East Bld. 3F, Osaka, Japan',
  company_city: 'Taiyujicho ',
  company_prefecture: 'Osaka',
  company_zip_code: '485-0041',
  company_country: 'Japan',
  company_phone_number: '0120-527-701',
  company_website: 'empregos.jp',
  company_social_media: { facebook: 'https://www.facebook.com/fujiarte', instagram: 'www.instagram.com/fujiarte.brasil', tiktok: 'https://www.tiktok.com/@fujiarte.brasil', youtube: 'https://www.youtube.com/@fujiarte.brasil' },
  company_description: 'A Fujiarte Co. Ltd., é empresa fundada em 1962 pioneira no ramo de outsourcing industrial. É uma das maiores na área de recrutamento de estrangeiros no Japão.',
  company_contact_email: 'empregos-mail@fujiarte.co.jp',
  company_category: 'Empreiteiras'
)
# fujiarte.company_logo.purge if fujiarte.company_logo.attached?
# fujiarte.company_banner.purge if fujiarte.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251117/reclame-jp/sl4beyekvhwmojj84gjf.jpg')
# fujiarte.company_logo.attach(
#   io: logo, 
#   filename: 'fujiarte.jpg', 
#   content_type: 'image/jpg')

# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251118/reclame-jp/vrmyteoh1vvd214crenc.png')
# fujiarte.company_banner.attach(
#   io: banner, 
#   filename: 'fujiarte.jpg', 
#   content_type: 'image/jpg')

suri_emu = Company.create!(
  company_name: 'UT Suri-emu ',
  company_address: 'Aichi-ken Okazaki-shi Harisaki-cho Furo16-1',
  company_city: 'Okazaki-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '444-0827',
  company_country: 'Japan',
  company_phone_number: '0564-55-6433 ',
  company_website: 'https://www.empregosjapan.com/',
  company_social_media: { facebook: 'https://www.facebook.com/UTSuriemu', instagram: 'https://www.instagram.com/ut_suriemu/' },
  company_description: 'Há mais de 30 anos aproximando pessoas e oportunidades de sucesso em todo o Japão. ',
  company_category: 'Empreiteiras',
  company_contact_email: 'yamashita@suri-emu.co.jp'
)
# suri_emu.company_logo.purge if suri_emu.company_logo.attached?
# suri_emu.company_banner.purge if suri_emu.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251126/reclame-jp/gpqa5gpcjgwhxhhsatxy.jpg')
# suri_emu.company_logo.attach(
#   io: logo,
#   filename: 'suri_emu.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251126/reclame-jp/maecvpdznjazncfkbqlp.png')
# suri_emu.company_banner.attach(
#   io: banner,
#   filename: 'suri_emu.jpg',
#   content_type: 'image/jpg'
# )

earnest = Company.create!(
  company_name: 'Earnest Corp.',
  company_address: 'Shizuoka-ken Hamamatsu-shi Naka-ku Nishiiiba-cho 20-8',
  company_city: 'Hamamatsu-shi',
  company_prefecture: 'Shizuoka',
  company_zip_code: '432-8038',
  company_country: 'Japan',
  company_phone_number: '053-545-9303',
  company_website: 'https://earnest-s.co.jp/',
  company_social_media: { facebook: 'https://www.facebook.com/profile.php?id=100083099392692' },
  company_description: 'Um local de trabalho onde todos podem demonstrar seus pontos fortes através do trabalho.',
  company_contact_email: 'm.osumi@earnest-s.co.jp',
  company_category: 'Empreiteiras'
)
# earnest.company_logo.purge if earnest.company_logo.attached?
# earnest.company_banner.purge if earnest.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251119/reclame-jp/pg6bqvoreneepu5ufxfw.jpg')
# earnest.company_logo.attach(
#   io: logo,
#   filename: 'earnest.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251119/reclame-jp/pg6bqvoreneepu5ufxfw.jpg')
# earnest.company_banner.attach(
#   io: banner,
#   filename: 'earnest.jpg',
#   content_type: 'image/jpg'
# )

ikai = Company.create!(
  company_name: 'Ikai Industry',
  company_address: 'Shizuoka-ken Hamamatsu-shi Naka-ku Sumiyoshi 3-18-6',
  company_city: 'Hamamatsu-shi',
  company_prefecture: 'Shizuoka',
  company_zip_code: '430-0906',
  company_country: 'Japan',
  company_phone_number: '053-476-6331',
  company_website: 'https://ikai-industry.co.jp/company/',
  company_social_media: { facebook: 'https://www.facebook.com/ikaioutsourcing', instagram: 'www.instagram.com/ikaioutsourcing' },
  company_description: 'Na Ikai Industry, estamos trabalhando para criar um ambiente onde os funcionários possam trabalhar com tranquilidade, fortalecendo o apoio antes mesmo de se candidatarem, como consultas de emprego e visitas às fábricas. Por favor, desfrute de uma vida estável em nossa empresa cujo lema é “Cuidar das pessoas”.',
  company_contact_email: 'tanaka_kenji@ikaigp.co.jp',
  company_category: 'Empreiteiras'
)
# ikai.company_logo.purge if ikai.company_logo.attached?
# ikai.company_banner.purge if ikai.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251120/reclame-jp/q8ihuuegvu1bkjbufteu.jpg')
# ikai.company_logo.attach(
#   io: logo,
#   filename: 'ikai.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251120/reclame-jp/xvid9twpgiayzxlbcs4k.jpg')
# ikai.company_banner.attach(
#   io: banner,
#   filename: 'ikai.jpg',
#   content_type: 'image/jpg'
# )

jto = Company.create!(
  company_name: 'JTO Corp.',
  company_address: 'Aichi-ken Anjo-shi Midori cho 1-16-6 T1 Midori cho 1F',
  company_city: 'Anjo-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '446-0055',
  company_country: 'Japan',
  company_phone_number: '0566-91-2880',
  company_website: 'https://www.jto-c.jp/',
  company_social_media: { facebook: 'https://www.facebook.com/empreiteirajto', instagram: 'https://www.instagram.com/empreiteira_jto/' },
  company_description: 'Empresa foi fundada em 2013 com o desejo de ser uma empresa prestativa que impressiona nossos clientes, combinando sabedoria e conhecimento, sendo criativa e engenhosa para ajudar a sociedade.',
  company_category: 'Empreiteiras'
)
# jto.company_logo.purge if jto.company_logo.attached?
# jto.company_banner.purge if jto.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251121/reclame-jp/ezcobsfdgrqqol7uf31q.jpg')
# jto.company_logo.attach(
#   io: logo,
#   filename: 'jto.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251119/reclame-jp/xkp4xlitjejizz3dmorj.jpg')
# jto.company_banner.attach(
#   io: banner,
#   filename: 'jto.jpg',
#   content_type: 'image/jpg'
# )

nichirin = Company.create!(
  company_name: 'Nichirin Group',
  company_address: 'Aichi-ken Handa-shi Yanabenaka-machi 2-98-1',
  company_city: 'Handa-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '475-0961',
  company_country: 'Japan',
  company_phone_number: '0569-89-7541',
  company_website: 'https://www.nichirinn.com/',
  company_social_media: { facebook: 'https://www.facebook.com/Nichirin.Honsha' },
  company_description: 'Contribuiremos para a sociedade através do poder do emprego através de serviços de maior valor acrescentado, como serviços de segurança e serviços de suporte à vida, a fim de responder amplamente ao envelhecimento da sociedade e à expansão do emprego estrangeiro.',
  company_category: 'Empreiteiras'
)
# nichirin.company_logo.purge if nichirin.company_logo.attached?
# nichirin.company_banner.purge if nichirin.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251122/reclame-jp/mktmyishppm6yj27byzn.jpg')
# nichirin.company_logo.attach(
#   io: logo,
#   filename: 'nichirin.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251122/reclame-jp/h1ceiq0ymumlgwao8uv3.png')
# nichirin.company_banner.attach(
#   io: banner,
#   filename: 'nichirin.jpg',
#   content_type: 'image/jpg'
# )

konishi = Company.create!(
  company_name: 'Konishi Sangyo Co., Ltd.',
  company_address: 'Shiga-ken Koka-shi Minakuchi-cho Shimoyama 666-85',
  company_city: 'Koka-shi',
  company_prefecture: 'Shiga',
  company_zip_code: '528-0063',
  company_country: 'Japan',
  company_phone_number: '0120-524-526',
  company_website: 'https://pt.konishisangyo.com/',
  company_social_media: { facebook: 'https://www.facebook.com/konishisangyo', instagram: 'https://www.instagram.com/konishi_sangyo/' },
  company_description: 'Na Konishi Sangyo Co., Ltd., não poupamos esforços para garantir um ambiente de trabalho agradável e seguro para todos. Nós nos esforçamos para criar um ambiente onde os funcionários possam trabalhar com tranquilidade.',
  company_contact_email: 'hiro@konishisangyo.com',
  company_category: 'Empreiteiras',
  company_logo_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2021/11/konishi1.jpg?fit=750%2C394&ssl=1',
)
# konishi.company_logo.purge if konishi.company_logo.attached?
# konishi.company_banner.purge if konishi.company_banner.attached?

# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251121/reclame-jp/krof2rgrlibafaxll5qg.jpg')
# konishi.company_banner.attach(
#   io: banner,
#   filename: 'konishi.jpg',
#   content_type: 'image/jpg'
# )

Company.create!(
  company_name: 'AOC - Job Center',
  company_address: '滋賀県草津市西大路町9番13号 西大路ビル3F',
  company_city: 'Kusatsu',
  company_prefecture: 'Shiga',
  company_zip_code: '525-0037',
  company_country: 'Japan',
  company_phone_number: '077-516-4101',
  company_website: 'https://www.aoc-net.co.jp/',
  company_social_media: { instagram: 'https://www.instagram.com/aoc_recruit/' },
  company_category: 'Empreiteiras',
  company_banner_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2021/11/aoc-job-center1-1.jpg?fit=750%2C394&ssl=1',
  company_logo_url: 'https://www.aoc-net.co.jp/wp-content/themes/aocwp/assets/common/svg/footerlogo.svg',
)

human = Company.create!(
  company_name: 'Human Corp.',
  company_address: 'Mie-ken Suzuka-shi Sanjo 3 chome 16-30',
  company_city: 'Suzuka-shi',
  company_prefecture: 'Mie',
  company_zip_code: '513-0806 ',
  company_country: 'Japan',
  company_phone_number: '059-392-8208',
  company_website: 'https://www.human-g.co.jp/',
  company_social_media: { facebook: 'https://www.facebook.com/profile.php?id=100083312253764'},
  company_description: 'A Human oferece um serviço que combina pessoas que procuram trabalho com empresas e organizações que procuram recursos humanos. ',
  company_category: 'Empreiteiras',
  company_banner_url: 'https://www.human-g.co.jp/files/libs/268/202302151552489542.png?1676516268',
)
# human.company_logo.purge if human.company_logo.attached?
# human.company_banner.purge if human.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251118/reclame-jp/ap0srewktk4h0dinyfg2.jpg')
# human.company_logo.attach(
#   io: logo,
#   filename: 'human.jpg',
#   content_type: 'image/jpg'
# )

marusan = Company.create!(
  company_name: 'Marusan Group',
  company_address: ' Aichi-ken Kariya-shi Hitotsugi-cho 1-1-17',
  company_city: 'Kariya-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '448-0003',
  company_country: 'Japan',
  company_phone_number: '0566-45-7961',
  company_website: 'https://marusantoyohashi.com/eng',
  company_social_media: { facebook: 'https://www.facebook.com/marusanquality', instagram: 'https://www.instagram.com/marusan.toyohashi/' },
  company_description: 'Marusan is a pioneering company in the eastern region of Mikawa in working with foreigners of Japanese descent and their spouses.',
  company_contact_email: 'marusanquality@gmail.com',
  company_category: 'Empreiteiras',
  company_logo_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2021/11/marusan-kariya1.jpg?fit=750%2C394&ssl=1',
)
# marusan.company_logo.purge if marusan.company_logo.attached?
# marusan.company_banner.purge if marusan.company_banner.attached?

# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251121/reclame-jp/po1wiwihbiwgvj5cwscn.jpg')
# marusan.company_banner.attach(
#   io: banner,
#   filename: 'marusan.jpg',
#   content_type: 'image/jpg'
# )

sankyo = Company.create!(
  company_name: 'Sankyo Techno',
  company_address: 'Aichi-ken Toyohashi-shi Nishimiyuki-cho Miyuki 22-2 Sankyo Bldg.',
  company_city: ' Toyohashi-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '441-8113',
  company_country: 'Japan',
  company_phone_number: '0120-253-032',
  company_website: 'https://sankyo-br.com/',
  company_social_media: { facebook: 'https://www.facebook.com/sankyots', instagram: 'www.instagram.com/sankyots', tiktok: 'www.tiktok.com/@sankyots' },
  company_description: 'Contribuímos para a concretização de uma sociedade próspera e saudável, tanto física, mental quanto espiritualmente, através da gestão baseada na área de terceirização e de recursos humanos que atendam às necessidades de nossos clientes.',
  company_contact_email: 'cadastro@sankyo-gr.com',
  company_category: 'Empreiteiras',
)
# sankyo.company_logo.purge if sankyo.company_logo.attached?
# sankyo.company_banner.purge if sankyo.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251124/reclame-jp/sa1gw5fa3uwuk5yjufsd.jpg')
# sankyo.company_logo.attach(
#   io: logo,
#   filename: 'sankyo.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251124/reclame-jp/kvscjerrymtohdjcsvh1.png')
# sankyo.company_banner.attach(
#   io: banner,
#   filename: 'sankyo.jpg',
#   content_type: 'image/jpg'
# )

fuji = Company.create!(
  company_name: 'Fuji Kogyosho',
  company_address: 'Gunma-ken Maebashi-shi Sojamachi 3-9-9',
  company_city: 'Maebashi-shi',
  company_prefecture: 'Gunma',
  company_zip_code: '371-0853',
  company_country: 'Japan',
  company_phone_number: '048-526-7111',
  company_website: 'https://fuji-ko.com/',
  company_social_media: { facebook: 'https://www.facebook.com/fujikogyoshou' },
  company_contact_email: 'shishido_sss@fuji-ko.com',
  company_category: 'Empreiteiras'
)
# fuji.company_logo.purge if fuji.company_logo.attached?
# fuji.company_banner.purge if fuji.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251117/reclame-jp/lkzd6szdaya48ilwbo9m.jpg')
# fuji.company_logo.attach(
#   io: logo,
#   filename: 'fuji.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251118/reclame-jp/rfqsxl3pxevffb98vjwb.jpg')
# fuji.company_banner.attach(
#   io: banner,
#   filename: 'fuji.jpg',
#   content_type: 'image/jpg'
# )

Company.create!(
  company_name: 'Shigoto no Tobira',
  company_address: 'Mie-ken Suzuka-shi Sanjo 2-5-1 Hunter Bld. 1F',
  company_city: 'Suzuka-shi',
  company_prefecture: 'Mie',
  company_zip_code: '513-0806',
  company_country: 'Japan',
  company_phone_number: '0120-0545-10',
  company_website: 'https://shigotonotobira.com/',
  company_social_media: { instagram: 'www.instagram.com/shigotonotobira555' },
  company_description: '“Porta de Trabalho” amplia novas possibilidades de carreira. Fornecemos informações e conselhos sobre diversas profissões e indústrias, e são úteis para aqueles que estão pensando em suas futuras carreiras.',
  company_category: 'Empreiteiras',
  company_banner_url: 'https://shigotonotobira.com/systemdata/data/content/2024-05-22_bda540235fa33c5c68e51dcd5fc95e89.webp?public=1&v=1716342860',
  company_logo_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2024/03/shigoto-no-tobira.jpg?fit=750%2C394&ssl=1',
)

sun_family = Company.create!(
  company_name: 'Sun Family',
  company_address: '滋賀県長浜市三田町1355-1',
  company_city: 'Nagahama shi',
  company_prefecture: 'Shiga',
  company_zip_code: '526-0242',
  company_country: 'Japan',
  company_phone_number: '0749-53-2450',
  company_website: 'https://www.sunfamily.info/',
  company_social_media: { facebook: 'https://www.facebook.com/SunfamilyEmpreiteira' },
  company_contact_email: 'ito@sunfamily.info',
  company_category: 'Empreiteiras',
)
# sun_family.company_logo.purge if sun_family.company_logo.attached?
# sun_family.company_banner.purge if sun_family.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251125/reclame-jp/nwiyyalitanf3ndvpugb.jpg')
# sun_family.company_logo.attach(
#   io: logo,
#   filename: 'sun_family.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251124/reclame-jp/fs5uj7pytpwyl4bdcqoz.png')
# sun_family.company_banner.attach(
#   io: banner,
#   filename: 'sun_family.jpg',
#   content_type: 'image/jpg'
# )

nikko = Company.create!(
  company_name: 'NIKKO empregos ',
  company_address: 'Aichi-ken Nagoya-shi Nakagawa-ku Nishihioki-cho 9-111',
  company_city: 'Nagoya-shi',
  company_prefecture: 'Aichi',
  company_zip_code: '454-0005',
  company_country: 'Japan',
  company_phone_number: '090-4915-3646',
  company_website: 'https://empregos-jp.com/',
  company_social_media: { facebook: 'www.facebook.com/nikko.empregos', instagram: 'www.instagram.com/nikko_empregos' },
  company_description: 'A Nikko é uma empresa com matriz em Nagoya, Aichi, fundada há mais de 30 anos com o intuito de promover o desenvolvimento econômico do Japão por meio do fornecimento de mão de obra qualificada às empresas de manufatura do Japão, e criação de oportunidades de trabalho.',
  company_contact_email: 'global@co-nikko.co.jp',
  company_category: 'Empreiteiras'
)
# nikko.company_logo.purge if nikko.company_logo.attached?
# nikko.company_banner.purge if nikko.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251123/reclame-jp/gyjiq98zkw1gqyp3ygg4.jpg')
# nikko.company_logo.attach(
#   io: logo,
#   filename: 'nikko.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251123/reclame-jp/vmyutarjdzxlkpt64lbf.png')
# nikko.company_banner.attach(
#   io: banner,
#   filename: 'nikko.jpg',
#   content_type: 'image/jpg'
# )

lp_staff = Company.create!(
  company_name: 'LP STAFF',
  company_address: 'Shizuoka ken kakegawa shi ekimae 11-1, Kakegawa-shi, Shizuoka, Japan',
  company_city: 'kakegawa shi',
  company_prefecture: 'Shizuoka',
  company_zip_code: '436-0077',
  company_country: 'Japan',
  company_social_media: { facebook: 'https://www.facebook.com/profile.php?id=100069316765489' },
  company_category: 'Empreiteiras',
)
# lp_staff.company_logo.purge if lp_staff.company_logo.attached?
# lp_staff.company_banner.purge if lp_staff.company_banner.attached?

# logo = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251119/reclame-jp/necujnxgtvxjemwawgpo.png')
# lp_staff.company_logo.attach(
#   io: logo,
#   filename: 'lp_staff.jpg',
#   content_type: 'image/jpg'
# )
# banner = URI.open('https://res.cloudinary.com/dckmqo1fb/image/upload/v1725251118/reclame-jp/rupgmrxtisjbg5mnlihi.png')
# lp_staff.company_banner.attach(
#   io: banner,
#   filename: 'lp_staff.jpg',
#   content_type: 'image/jpg'
# )

puts 'EMPREITEIRAS created!'

############################################################################################################

puts 'Create company associations'

role = CompaniesUser::ROLE

def associate_user_with_company(user, company, role)
  selected_role = role.sample
  CompaniesUser.create!(
    user: user,
    company: company,
    role: selected_role
  )
end

associate_user_with_company(user_company, company1, role)
associate_user_with_company(user_company2, company1, role)

puts 'Users linked to companies with roles assigned!'

############################################################################################################


puts 'Creating complaints...'

complaints = [ 
  Complaint.create!(
    title: 'Produto Defeituoso',
    comment: 'Comprei um eletrônico dessa empresa e, após apenas duas semanas de uso, o dispositivo começou a apresentar problemas constantes de funcionamento. Entrei em contato com o suporte, mas a assistência foi insatisfatória e o problema não foi resolvido.',
    review: rand(1..5),
    company: company1,
    user: user_normal,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Produto não entregue',
    comment: 'A empresa prometeu entregar meu pedido em 7 dias úteis, mas o produto só chegou após 3 semanas. Não houve comunicação clara sobre o atraso e, quando tentei buscar informações, a resposta foi demorada e pouco útil.',
    review: rand(1..5),
    company: company1,
    user: user_normal,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Serviço ao Cliente Insatisfatório',
    comment: 'Experiência extremamente negativa com o atendimento ao cliente. Ao tentar resolver um problema com minha conta, fui tratado com desdém e a solução oferecida foi inadequada. A empresa não demonstrou preocupação com a minha situação.',
    review: rand(1..5),
    company: company1,
    user: user_normal,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Cobrança Indevida',
    comment: 'Fui cobrado por um serviço que não contratei. Após revisar meu extrato, percebi que houve uma cobrança adicional que não foi autorizada. O processo de contestação foi burocrático e demorado, e o problema ainda não foi resolvido.',
    review: rand(1..5),
    company: company1,
    user: user_normal,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Qualidade do Produto Abaixo do Esperado',
    comment: 'O produto recebido não corresponde às especificações apresentadas no site. A qualidade é inferior ao que foi descrito e a empresa não oferece um retorno eficiente para resolver o problema. Senti-me enganado com a discrepância entre a descrição e o item recebido.',
    review: rand(1..5),
    company: company1,
    user: user_normal,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  )
]

puts 'Complaints created!'

############################################################################################################

puts 'Creating responses...'

3.times do
  Response.create!(
    content: 'Essa é a resposta da empresa ao seu comentário. Lamentamos o ocorrido e estamos trabalhando para resolver o problema. Entre em contato conosco para que possamos ajudá-lo da melhor forma possível.',
    complaint: complaints.sample,
    user: company_users.sample,
    company: company1,
  )
end

puts 'Responses created!'
