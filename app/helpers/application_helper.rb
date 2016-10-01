module ApplicationHelper
  def sexs
    @options = [
      [t(:male), t(:male)],
      [t(:female) , t(:female)]
    ]
    return @options
  end
  def grades
    @options = [
    #  [t(:primary), t(:primary)],
    #  [t(:middle) , t(:middle)],
      [t(:high), t(:high)],
      [t(:bs), t(:bs)],
      [t(:ms), t(:ms)],
      [t(:phd), t(:phd)],
      [t(:postdoc), t(:postdoc)]
    ]
    return @options
  end
  def paginate(collection, params= {})
  will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
end
end
