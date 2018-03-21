require "video.rb"

class TopController < ApplicationController

  def index
    @videos = Video.main()
    @videos_ranking = Video.main_ranking()
    @videos_new = @videos_ranking
  end

  def tag
    @videos = Video.tag(params[:id])
    @videos_ranking = Video.main_ranking()
    @videos_new = @videos_ranking
    @tag_word = params[:id]
    @tag_name = params[:id]
    tag_names = @tag_name.split(" ")
    if tag_names[1]
      @tag_name = tag_names[0]
      @second_tag_name = tag_names[1]
    end
  end

  def category
    @videos = Video.category(params[:id])
    @videos_ranking = @videos
    @videos_new = @videos
    if params[:id].include?("ニュース")
      @category_name = "ニュース"
    elsif params[:id].include?("CM")
      @category_name = "CM・PV"
    elsif params[:id].include?("試乗")
      @category_name = "試乗・解説"
    elsif params[:id].include?("大会")
      @category_name = "大会・イベント"
    elsif params[:id].include?("テクノロジー")
      @category_name = "テクノロジー"
    elsif params[:id].include?("エンタメ")
      @category_name = "エンタメ"
    end
  end

  def show
    @video = Video.detail(params[:id])
    @tag = @video[0][:tag][1..-2].split(", ")
    @videos_ranking = @video
    @videos_new = @video
  end

  def tag_index

  end

end
