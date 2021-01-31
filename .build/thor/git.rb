class Git < Thor
  include Thor::Actions

  desc "tag-minor", "increments minor tag and pushes"
  def tag_minor
    run "git version-bump mi"
    run "git push origin #{latest_tag}"
  end

  desc "tag-patch", "increments tag tag and pushes"
  def tag_patch
    run "git version-bump p"
    run "git push origin #{latest_tag}"
  end

  no_commands do
    def latest_tag
      `git tag --list`.split("\n").reverse.first
    end
  end
end