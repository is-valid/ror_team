ActiveAdmin.register Comment do

  menu parent: 'News'

  filter :description, as: :string

  index do
    selectable_column
    column :id
    column :description
    column 'Post' do |comment|
      comment.post.title
    end
    default_actions
  end

  form do |f|
    f.inputs 'Comments' do
      f.input :post
      f.input :nickname
      f.input :description
    end
    f.actions
  end

  controller do
    def scoped_collection
      Comment.includes([:post]).page(params[:page]).per(30)
    end

    def create
      @comment = current_admin_user.comments.build(comment_params)
      if current_admin_user && current_admin_user.role == 'admin'
        @comment.admin = true
      else
        @comment.admin = false
      end
      if @comment.save
        redirect_to admin_comment_path(@post), notice: 'Comment was successfully created.'
      else
        render :new, notice: 'Error has occurred while creating.'
      end
    end

    def update
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        redirect_to admin_comment_url(@comment), notice: 'Comment was successfully updated.'
      else
        render :edit, notice: 'Error has occurred while updating.'
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:description, :post_id, :commentable_id, :commentable_type, :nickname)
    end
  end

end