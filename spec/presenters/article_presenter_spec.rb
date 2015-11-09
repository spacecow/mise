require './app/presenters/article_presenter'

describe ArticlePresenter do

  let(:presenter){ ArticlePresenter.new article, view }
  let(:article){ double :article }
  let(:view){ double :view }
  let(:params){ [] }

  subject{ presenter.send function, *params }

end
