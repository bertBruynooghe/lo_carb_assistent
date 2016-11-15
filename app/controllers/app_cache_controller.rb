class AppCacheController < ApplicationController
  # Rails controller action for an HTML5 cache manifest file.
    # Generates a plain text list of cache_lines that changes
    # when one of the listed cache_lines change...
    # So the client knows when to refresh its cache.
  def show
    @cache_lines = ["CACHE MANIFEST\n"]

    @cache_lines << 'meals'
    @cache_lines << 'insulin_doses'
    @cache_lines << 'blood_sugar_readings'
    @cache_lines << 'nutrients'

    add_from_asset_manifest

    @cache_lines << "\nNETWORK:"
    @cache_lines << '*'

    @cache_lines << "\# Latest Nutrients Update: #{Nutrient.order(updated_at: :desc).limit(1).map(&:updated_at)}"
    @cache_lines << "\# Latest Meals Update: #{Meal.order(updated_at: :desc).limit(1).map(&:updated_at)}"
    @cache_lines << "\# Latest Ingredients Update: #{Ingredient.order(updated_at: :desc).limit(1).map(&:updated_at)}"
    @cache_lines << "\# Latest InsulinDoses Update: #{InsulinDose.order(updated_at: :desc).limit(1).map(&:updated_at)}"
    @cache_lines << "\# Latest BloodSugar Readings Update: #{BloodSugarReading.order(updated_at: :desc).limit(1).map(&:updated_at)}"

    # digest = Digest::SHA1.new
    # @cache_lines.each do |f|
    #   actual_file = File.join(Rails.root,'public',f)
    #   digest << "##{File.mtime(actual_file)}" if File.exist?(actual_file)
    # end
    # @cache_lines << "\n# Modification Digest: #{digest.hexdigest}"
    render plain: @cache_lines.join("\n"), content_type: 'text/cache-manifest', layout: nil
  end

  protected
  
  def add_from_asset_manifest
    manifest_file = File.join(Rails.root,'public','assets','manifest.yml')
    if FileTest.exist?(manifest_file)
      File.open(manifest_file).each do |l|
        if l.include? ":"
          @cache_lines << "assets/#{l.split(":").last().strip()}"
        end
      end
    end
  end
end
