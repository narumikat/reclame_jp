module CompaniesHelper
  def can_edit_company?(company)
    user_signed_in? && 
    current_page?(user_user_companies_path(current_user)) && 
    current_user.company? && 
    (company.users.include?(current_user) || current_user.admin?) || current_user.admin?
  end

  def company_button_for(current_user)
    if current_user.companies.any? && current_user.companies.size == 1
      btn_text = 'Ver empresa'
      link_path = user_user_companies_path(current_user, companies_ids: current_user.companies.pluck(:id))
    elsif current_user.companies.size > 1
      btn_text = 'Ver empresas'
      link_path = user_user_companies_path(current_user, companies_ids: current_user.companies.pluck(:id))
    else
      btn_text = 'Cadastre sua empresa'
      link_path = new_company_path
    end

    render 'components/btn_companies', btn_text: btn_text, link_path: link_path
  end
end
