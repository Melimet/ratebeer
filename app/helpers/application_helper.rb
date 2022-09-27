module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit me!', url_for([:edit, item]))
    del = link_to('Destroy me', item, method: :delete,
                                      form: { data: { turbo_confirm: "Are you sure ?" } })
    raw("#{edit} #{del}")
  end
end
