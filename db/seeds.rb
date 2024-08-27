Complaint.destroy_all
Response.destroy_all
CompaniesUser.destroy_all
Company.destroy_all
User.destroy_all

puts 'Creating users...'

# USER ADMIN
User.create!(
  username: 'user_admin',
  email: 'admin@mail.com',
  password: 'admin123',
  password_confirmation: 'admin123',
  first_name: 'Admin',
  last_name: 'One',
  phone_number: '000-000-0000',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: true,
)

# USER SEM RECLAMACOES 
User.create!(
  username: 'user_no_complaints',
  email: 'usermail@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'No Complaints',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
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

user_normal2 = User.create!(
  username: 'user_normal2',
  email: 'user2@mail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'User',
  last_name: 'Two',
  phone_number: '1234567890',
  address: '123 Main St',
  city: 'New York',
  state: 'NY',
  zip_code: '10001',
  admin: false,
  is_company: false
)

normal_users = [user_normal, user_normal2]

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
  company_name: 'Company Test',
  company_address: '123 Main St',
  company_city: 'New York',
  company_prefecture: Company::COMPANY_PREFECTURE.sample,
  company_zip_code: '10001',
  company_country: 'USA',
  company_phone_number: '0270-21-8155',
  company_website: 'www.companytest.com',
  company_social_media: { facebook: 'www.facebook.com/companitest', twitter: 'www.twitter.com/companitest' },
  company_description: 'Company One is a company that does things.',
  company_contact_name: 'John Doe',
  company_contact_email: 'company@mail.com',
  company_category: Company::COMPANY_CATEGORY.sample
)


############################################################################################################

puts "Creating company EMPREITEIRAS..."

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/283074422_2104233369754770_3491773026005714977_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=0qBlT_o3bqMQ7kNvgFd5ptV&_nc_ht=scontent-nrt1-2.xx&_nc_gid=AwqfjIhG7qJIi7n8ePnjvTz&oh=00_AYCyMLwxjVMTuTpyj5z2hTmkj0M6pBjsCRqfuxe_2XSY0Q&oe=66D2F939',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/355885530_302298135481611_2941827571822001198_n.png?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=wKtc9lNKBagQ7kNvgEW3ofv&_nc_ht=scontent-nrt1-2.xx&oh=00_AYCjdyNu84dLuTl72b3Zq0NjdhTWfl3z5k7jvq48N2YC0Q&oe=66D2EA51',
)

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/447674430_840666251425619_5721174446051250998_n.png?_nc_cat=101&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=gBC9wceTyhsQ7kNvgELit8Z&_nc_ht=scontent-nrt1-2.xx&oh=00_AYC__NfUI4gt2oLWMRpzSU68rwphLgc0ZDLTYkNyc8sk4g&oe=66D30A21',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/281847748_5288348814541834_4110152173776724300_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=40ACrOMRYFcQ7kNvgETtggZ&_nc_ht=scontent-nrt1-2.xx&oh=00_AYCUNMkNoutZs8-zCL-E7DSNLmdOupiD87n7B2cK2916Jw&oe=66D31DEC',
)

Company.create!(
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
  company_contact_email: 'yamashita@suri-emu.co.jp',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/315846892_5662055657193095_2597838303728041700_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=86c6b0&_nc_ohc=Xh3gKRdEV0EQ7kNvgF-4jst&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDwxpzMaM0sqPWFvIVPvsARRngFEhu8uvBYdb_HkX411Q&oe=66D3102C',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/271487238_4748499388548731_4826216284450439333_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=8JYHLuqaweUQ7kNvgESTaDE&_nc_ht=scontent-nrt1-2.xx&oh=00_AYB2eXxs_KF43kpyVQzcxEX5xl7xH3RbO1_FVw-jYgH6eg&oe=66D313F0',
)

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/289953193_106517875448887_6430435018767223456_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=QG0EhtxaBfsQ7kNvgH-VnQW&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDT5LLM06NYDe8QZQ0cJQR402Ws7qLEXA0ZED5gFMsdAg&oe=66D320CD',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/294990714_119152430852098_5859083643534488008_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=1-uUNnSR65oQ7kNvgG6OQVy&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDcz2G9-h0LOwA_F27MlSMo_Fs_yMN_kz-uA0v_r4pxKw&oe=66D2F8C0',
)

Company.create!(
  company_name: 'Ikai Industry',
  company_address: 'Shizuoka-ken Hamamatsu-shi Naka-ku Sumiyoshi 3-18-6',
  company_city: 'amamatsu-shi',
  company_prefecture: 'Shizuoka',
  company_zip_code: '430-0906',
  company_country: 'Japan',
  company_phone_number: '053-476-6331',
  company_website: 'https://ikai-industry.co.jp/company/',
  company_social_media: { facebook: 'https://www.facebook.com/ikaioutsourcing', instagram: 'www.instagram.com/ikaioutsourcing' },
  company_description: 'Na Ikai Industry, estamos trabalhando para criar um ambiente onde os funcionários possam trabalhar com tranquilidade, fortalecendo o apoio antes mesmo de se candidatarem, como consultas de emprego e visitas às fábricas. Por favor, desfrute de uma vida estável em nossa empresa cujo lema é “Cuidar das pessoas”.',
  company_contact_email: 'tanaka_kenji@ikaigp.co.jp',
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/251323911_4810141392363775_3541057071720167543_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=mrVxpYoN01YQ7kNvgGHuk4H&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDZZ-JCA1KZu6nUUur4eUkO8DSWUkZxi9lHLNMJWiFN7w&oe=66D30608',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/326927363_904914170641997_6343719978753973999_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Nmjt-QuhlwMQ7kNvgHfP1qg&_nc_ht=scontent-nrt1-2.xx&oh=00_AYCjbQxOEZZ_aAsd21NyPZvCeD_4uje74yNZSNuYSUq1_w&oe=66D32829',
)

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/415054789_311174278581658_5896365693617125659_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=nP3EqkWsjgQQ7kNvgGwuJVO&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDv84vDR1HG_hfPcEcXqgb4Jw59dr42pTBjFFbVYI6Dng&oe=66D30C44',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/331673296_1857127327971862_3761113296173349280_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=eR5IQfz3Za4Q7kNvgEQ41l2&_nc_ht=scontent-nrt1-2.xx&oh=00_AYC0_xm73-H8spUFdwSyLqnOQuju7D6PVuHyqpQgBZFT6g&oe=66D3130A',
)

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/302132305_480368020765828_3907449284438604058_n.png?_nc_cat=100&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=xufB_-5oOZIQ7kNvgGF5Nq0&_nc_ht=scontent-nrt1-2.xx&oh=00_AYBsj3NbQrCr28rn_lNItsWQRVGHkS-56bvbFGZ4idrkDw&oe=66D302C3',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/300450397_480368017432495_6149622439946288248_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=kFmYjYjfOI4Q7kNvgFIoINz&_nc_ht=scontent-nrt1-2.xx&oh=00_AYD-gpPCqLA2AlbH9vtLx6mUeqBkIV5f4VsK6n4otPHanw&oe=66D313A6',
)

Company.create!(
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
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/452941274_922378589933238_6650148896585100807_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=AaSFJGjlm2sQ7kNvgG4pMwn&_nc_ht=scontent-nrt1-2.xx&oh=00_AYAWihfNQurzL3gvq_NYcaU-vvYYCxcS3jIoAvtmqSKucg&oe=66D32EC1',
  company_logo_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2021/11/konishi1.jpg?fit=750%2C394&ssl=1',
)

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

Company.create!(
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
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/277570623_104444868897516_2321695864494571218_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=i-CBdDc8vGYQ7kNvgFWJlrz&_nc_ht=scontent-nrt1-2.xx&oh=00_AYA65pYkjm8OzJZTLGXlKz2mqjdToT11R289wOIHc0pn8w&oe=66D33412',
)

Company.create!(
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
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/299115255_464550519016903_1825612492205577218_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=Cp81_13zYv8Q7kNvgF3O1NY&_nc_ht=scontent-nrt1-2.xx&oh=00_AYAJypY5fz4coXn9btAn2pI2DoRMqyG0Zuj_rBkXGrsawQ&oe=66D2FF31',
  company_logo_url: 'https://i0.wp.com/jobsonline.jp/wp-content/uploads/2021/11/marusan-kariya1.jpg?fit=750%2C394&ssl=1',
)

Company.create!(
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
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t1.6435-9/33834434_1709332889119924_7021427872829014016_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=2a1932&_nc_ohc=lTo1ps8LangQ7kNvgGorYqG&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDjFE1sQxJeBkU6nxmwR1ivCZXbV1qNSdIrVv3EAIsARw&oe=66F4CE01',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/348436917_3432234230363835_404246973378801796_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=NOE4H4sxL9IQ7kNvgExpMTz&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDE7gnBYZapxp9fl-2iQNmUd0_YohMLsZ3ByROe8MYrNQ&oe=66D31CEF',
)

Company.create!(
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
  company_category: 'Empreiteiras',
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/262637073_115341660975647_2518947275984599450_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=spwKUZMMSoAQ7kNvgFuy0p_&_nc_ht=scontent-nrt1-2.xx&oh=00_AYDkrOsQeQsOyFItiEKI0U15taA2rCQIbmth5lTRV0FVaQ&oe=66D31258',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/262149504_114900064353140_1744445676912348532_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=_MzrZNem3W8Q7kNvgEfXcJ0&_nc_ht=scontent-nrt1-2.xx&oh=00_AYBrRkYKFb4vBYD7q9PpCvgnVZ2UKSAAMHUzzr5BWj7z9A&oe=66D3041B',
)

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

Company.create!(
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
  company_banner_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/301177490_507380851387830_8864027811105492643_n.png?_nc_cat=106&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=xO8rAu1Dr_cQ7kNvgHKsZ7m&_nc_ht=scontent-nrt1-2.xx&_nc_gid=ACN7LwMq4itCzpABs5HzIt8&oh=00_AYCGk2XlwFe5Y1RrsgP2OV7HIXXH6QOXll9Tl-V2DwL5fA&oe=66D32482',
  company_logo_url: 'https://scontent-nrt1-2.xx.fbcdn.net/v/t39.30808-6/271653184_4279371895501424_7959931784793890947_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=Aoq5y2e815QQ7kNvgG26OEC&_nc_ht=scontent-nrt1-2.xx&oh=00_AYCjFa-A8Z3Bb7MHsrejfwO-RzNmQoxUMi1wgwq1HkAueg&oe=66D311AF',
)

# Company.create!(
#   company_name: '',
#   company_address: '',
#   company_city: '',
#   company_prefecture: '',
#   company_zip_code: '',
#   company_country: '',
#   company_phone_number: '',
#   company_website: '',
#   company_social_media: { facebook: '', instagram: '' },
#   company_description: '',
#   company_contact_email: '',
#   company_category: 'Empreiteiras',
#   company_banner_url: '',
#   company_logo_url: '',
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
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Produto não entregue',
    comment: 'A empresa prometeu entregar meu pedido em 7 dias úteis, mas o produto só chegou após 3 semanas. Não houve comunicação clara sobre o atraso e, quando tentei buscar informações, a resposta foi demorada e pouco útil.',
    review: rand(1..5),
    company: company1,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Serviço ao Cliente Insatisfatório',
    comment: 'Experiência extremamente negativa com o atendimento ao cliente. Ao tentar resolver um problema com minha conta, fui tratado com desdém e a solução oferecida foi inadequada. A empresa não demonstrou preocupação com a minha situação.',
    review: rand(1..5),
    company: company1,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Cobrança Indevida',
    comment: 'Fui cobrado por um serviço que não contratei. Após revisar meu extrato, percebi que houve uma cobrança adicional que não foi autorizada. O processo de contestação foi burocrático e demorado, e o problema ainda não foi resolvido.',
    review: rand(1..5),
    company: company1,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  ),
  Complaint.create!(
    title: 'Qualidade do Produto Abaixo do Esperado',
    comment: 'O produto recebido não corresponde às especificações apresentadas no site. A qualidade é inferior ao que foi descrito e a empresa não oferece um retorno eficiente para resolver o problema. Senti-me enganado com a discrepância entre a descrição e o item recebido.',
    review: rand(1..5),
    company: company1,
    user: normal_users.sample,
    complaint_category: Complaint::COMPLAINT_CATEGORY.sample
  )
]

puts 'Complaints created!'

############################################################################################################

puts 'Creating responses...'

10.times do
  Response.create!(
    content: 'This is a response to a complaint.',
    complaint: complaints.sample,
    user: company_users.sample,
    company: company1,
  )
end

puts 'Responses created!'
