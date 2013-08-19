class OpenSourceCommits < Tricle::Metric
  def size_for_range(start_at, end_at)
    GITHUB_COMMITS_BY_TIME.items_for_range(start_at, end_at).length
  end

  def total
    GITHUB_COMMITS_BY_TIME.all_items.length
  end
end
