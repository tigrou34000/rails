# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Lang.create!([
		{
			iso: "fr",
			language: "francais"
		} , {
			iso: "en",
			language: "anglais"
		}
	])
User.create!([
		{
			name: "thomas",
			email: "tiger63.thomas@gmail.com",
			password: "011284"
		} 
	])
Article.create!([
		{
			visible: true,
			price: "10"
		},{
			visible: true,
			price: "5"
		}
	])
Category.create!([
		{
			visible:true
		}


	])
ArticleToCategory.create!([
		{
			article_id: 1,
			category_id: 1
		},{
			article_id: 2,
			category_id: 1
		}
	])
ArticleTranslation.create!([
		{
			article_id: 1,
			lang_id: 1,
			title: "mon titre en francais 1 ",
			description: "ma description en francais"
		},	{
			article_id: 1,
			lang_id: 2,
			title: "my title in english 1 ",
			description: "my description in english description"
		},{
			article_id: 2,
			lang_id: 1,
			title: "mon titre en francais 2",
			description: "ma description en francais"
		},	{
			article_id: 2,
			lang_id: 2,
			title: "my title in english 2",
			description: "my description in english description"
		}
	])


CategoryTranslation.create!([
		{
			category_id: 1,
			lang_id: 1,
			title: "ma categorie en francais"
		},
		{
			category_id: 1,
			lang_id: 2,
			title: "my category in english"
		},

	])

