class Video < ApplicationRecord

  require 'google/api_client'

  DEVELOPER_KEY = '######################'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def self.get_service
    client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end


  ####################################### Topページ一覧
  def self.main
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => '自動車'
      opt :max_results, 'Max results', :type => :int, :default => 5
    end

    client, youtube = get_service

    begin

      # データの格納庫
      ids = []
      urls = []
      titles = []
      descriptions = []
      channels = []
      thumbnails = []
      views = []
      tags = []
      comments = []

      # Serachで情報を取得
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          #:order => 'date'
        }
      )

      # 各要素を格納
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            ids << "#{search_result.id.videoId}"
            urls << "http://www.youtube.com/watch?v=#{search_result.id.videoId}"
            titles << "#{search_result.snippet.title}"
            descriptions << "#{search_result.snippet.description}"
            channels << "#{search_result.snippet.channelTitle}"
            thumbnails << "#{search_result.snippet.thumbnails.medium.url}"
          end
        end

      # 視聴回数を取得するためにidの配列を整形
      fixed_ids = ids.join(", ")

      # Videoから視聴回数を取得
      video_detail = client.execute!(
        :api_method => youtube.videos.list,
        :parameters => {
          :part => 'statistics, snippet',
          :id => fixed_ids
        }
      )

      # 視聴回数を格納
      video_detail.data.items.each do |search_result|
            views << "#{search_result.statistics.viewCount}"
            tags << "#{search_result.snippet.tags}"
          end

      # 配列を指定するための数字列を生成
      number = ids.length - 1
      numbers = Range.new(0,number)

      # 動画情報が順番にが入った配列を生成
      videos = []

      # 取得したデータを入れるに保存
      for i in numbers do
        videos[i] = {
          id: ids[i],
          url: urls[i],
          title: titles[i],
          description: descriptions[i],
          channel: channels[i],
          thumbnail: thumbnails[i],
          views: views[i],
          tag: tags[i]
        }
      end

      # 戻り値に配列を指定
      return videos

      rescue Google::APIClient::TransmissionError => e
        puts "e.result.body"
      end

  end

  ####################################### Topページランキング
  def self.main_ranking
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => '自動車'
      opt :max_results, 'Max results', :type => :int, :default => 5
    end

    client, youtube = get_service

    begin

      # データの格納庫
      ids = []
      urls = []
      titles = []
      descriptions = []
      channels = []
      thumbnails = []
      views = []
      tags = []
      comments = []

      # Serachで情報を取得
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          #:order => 'date'
        }
      )

      # 各要素を格納
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            ids << "#{search_result.id.videoId}"
            urls << "http://www.youtube.com/watch?v=#{search_result.id.videoId}"
            titles << "#{search_result.snippet.title}"
            descriptions << "#{search_result.snippet.description}"
            channels << "#{search_result.snippet.channelTitle}"
            thumbnails << "#{search_result.snippet.thumbnails.default.url}"
          end
        end

      # 視聴回数を取得するためにidの配列を整形
      fixed_ids = ids.join(", ")

      # Videoから視聴回数を取得
      video_detail = client.execute!(
        :api_method => youtube.videos.list,
        :parameters => {
          :part => 'statistics, snippet',
          :id => fixed_ids
        }
      )

      # 視聴回数を格納
      video_detail.data.items.each do |search_result|
            views << "#{search_result.statistics.viewCount}"
            tags << "#{search_result.snippet.tags}"
          end

      # 配列を指定するための数字列を生成
      number = ids.length - 1
      numbers = Range.new(0,number)

      # 動画情報が順番にが入った配列を生成
      videos = []

      # 取得したデータを入れるに保存
      for i in numbers do
        videos[i] = {
          id: ids[i],
          url: urls[i],
          title: titles[i],
          description: descriptions[i],
          channel: channels[i],
          thumbnail: thumbnails[i],
          views: views[i],
          tag: tags[i]
        }
      end

      # 戻り値に配列を指定
      return videos

      rescue Google::APIClient::TransmissionError => e
        puts "e.result.body"
      end

  end


  ####################################### Categoryページ一覧
  def self.category(category_word)
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => category_word
      opt :max_results, 'Max results', :type => :int, :default => 5
    end

    client, youtube = get_service

    begin

      # データの格納庫
      ids = []
      urls = []
      titles = []
      descriptions = []
      channels = []
      thumbnails = []
      views = []
      tags = []
      comments = []

      # Serachで情報を取得
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          #:order => 'date'
        }
      )

      # 各要素を格納
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            ids << "#{search_result.id.videoId}"
            urls << "http://www.youtube.com/watch?v=#{search_result.id.videoId}"
            titles << "#{search_result.snippet.title}"
            descriptions << "#{search_result.snippet.description}"
            channels << "#{search_result.snippet.channelTitle}"
            thumbnails << "#{search_result.snippet.thumbnails.medium.url}"
          end
        end

      # 視聴回数を取得するためにidの配列を整形
      fixed_ids = ids.join(", ")

      # Videoから視聴回数を取得
      video_detail = client.execute!(
        :api_method => youtube.videos.list,
        :parameters => {
          :part => 'statistics, snippet',
          :id => fixed_ids
        }
      )

      # 視聴回数を格納
      video_detail.data.items.each do |search_result|
            views << "#{search_result.statistics.viewCount}"
            tags << "#{search_result.snippet.tags}"
          end

      # 配列を指定するための数字列を生成
      number = ids.length - 1
      numbers = Range.new(0,number)

      # 動画情報が順番にが入った配列を生成
      videos = []

      # 取得したデータを配列に保存
      for i in numbers do
        videos[i] = {
          id: ids[i],
          url: urls[i],
          title: titles[i],
          description: descriptions[i],
          channel: channels[i],
          thumbnail: thumbnails[i],
          views: views[i],
          tag: tags[i]
        }
      end

      # 配列を返り値に指定
      return videos

      rescue Google::APIClient::TransmissionError => e
        puts "e.result.body"
      end

  end


  ####################################### Tagページ一覧
  def self.tag(tag_name)
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => tag_name
      opt :max_results, 'Max results', :type => :int, :default => 5
    end

    client, youtube = get_service

    begin

      # データの格納庫
      ids = []
      urls = []
      titles = []
      descriptions = []
      channels = []
      thumbnails = []
      views = []
      tags = []
      comments = []

      # Serachで情報を取得
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          #:order => 'date'
        }
      )

      # 各要素を格納
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            ids << "#{search_result.id.videoId}"
            urls << "http://www.youtube.com/watch?v=#{search_result.id.videoId}"
            titles << "#{search_result.snippet.title}"
            descriptions << "#{search_result.snippet.description}"
            channels << "#{search_result.snippet.channelTitle}"
            thumbnails << "#{search_result.snippet.thumbnails.medium.url}"
          end
        end

      # 視聴回数を取得するためにidの配列を整形
      fixed_ids = ids.join(", ")

      # Videoから視聴回数を取得
      video_detail = client.execute!(
        :api_method => youtube.videos.list,
        :parameters => {
          :part => 'statistics, snippet',
          :id => fixed_ids
        }
      )

      # 視聴回数を格納
      video_detail.data.items.each do |search_result|
            views << "#{search_result.statistics.viewCount}"
            tags << "#{search_result.snippet.tags}"
          end

      # 配列を指定するための数字列を生成
      number = ids.length - 1
      numbers = Range.new(0,number)

      # 動画情報が順番にが入った配列を生成
      videos = []

      # 取得したデータを配列に保存
      for i in numbers do
        videos[i] = {
          id: ids[i],
          url: urls[i],
          title: titles[i],
          description: descriptions[i],
          channel: channels[i],
          thumbnail: thumbnails[i],
          views: views[i],
          tag: tags[i]
        }
      end

      # 配列を返り値に指定
      return videos

      rescue Google::APIClient::TransmissionError => e
        puts "e.result.body"
      end

  end


  ####################################### 詳細ページ
  def self.detail(video)
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => video
      opt :max_results, 'Max results', :type => :int, :default => 1
    end

    client, youtube = get_service

    begin

      # データの格納庫
      ids = []
      urls = []
      titles = []
      descriptions = []
      channels = []
      thumbnails = []
      views = []
      tags = []
      comments = []

      # Serachで情報を取得
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          #:order => 'date'
        }
      )

      # 各要素を格納
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            ids << "#{search_result.id.videoId}"
            urls << "http://www.youtube.com/watch?v=#{search_result.id.videoId}"
            titles << "#{search_result.snippet.title}"
            descriptions << "#{search_result.snippet.description}"
            channels << "#{search_result.snippet.channelTitle}"
            thumbnails << "#{search_result.snippet.thumbnails.medium.url}"
          end
        end

      # 視聴回数を取得するためにidの配列を整形
      fixed_ids = ids.join(", ")

      # Videoから視聴回数を取得
      video_detail = client.execute!(
        :api_method => youtube.videos.list,
        :parameters => {
          :part => 'statistics, snippet',
          :id => fixed_ids
        }
      )

      # 視聴回数を格納
      video_detail.data.items.each do |search_result|
            views << "#{search_result.statistics.viewCount}"
            tags << "#{search_result.snippet.tags}"
          end

      # 配列を指定するための数字列を生成
      number = ids.length - 1
      numbers = Range.new(0,number)

      # 動画情報が順番にが入った配列を生成
      videos = []

      # 取得したデータを配列に保存
      for i in numbers do
        videos[i] = {
          id: ids[i],
          url: urls[i],
          title: titles[i],
          description: descriptions[i],
          channel: channels[i],
          thumbnail: thumbnails[i],
          views: views[i],
          tag: tags[i]
        }
      end

      # 配列を返り値に指定
      return videos

      rescue Google::APIClient::TransmissionError => e
        puts "e.result.body"
      end
    end

end
