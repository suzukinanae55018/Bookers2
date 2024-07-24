# frozen_string_literal: true

class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
    # 外部キーのbook_idにはbookのidを入れる
    # redirect_back(fallback_location: root_path)
    # redirect_to request.referer
  end


  def destroy
    # book = BookComment.find(params[:book_id])
    # comment = current_user.book_comments.find_by(book_id: book.id)←一致していない
    　　 # @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])bookcommentから引っ張ってきた:book_idをbook_idに代入する
    # comment.destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # redirect_back(fallback_location: root_path)
    # redirect_to request.referer
  end

  private
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
end
